return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = true },
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local is_nixos = vim.fn.filereadable '/etc/NIXOS' == 1
            local lsp = require 'lspconfig'
            local diag = vim.diagnostic

            diag.config {
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            }

            require('lsp_lines').setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if cmp_ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            else
                vim.notify(
                    'cmp_nvim_lsp not available, using basic capabilities',
                    vim.log.levels.WARN
                )
            end

            local function get_bin(pkg)
                if is_nixos then
                    local handle =
                        io.popen('command -v ' .. pkg .. ' 2>/dev/null')
                    if not handle then
                        return nil
                    end
                    local result = handle:read('*a'):gsub('\n', '')
                    handle:close()
                    return result ~= '' and result or nil
                end
                local exepath = vim.fn.exepath(pkg)
                return exepath ~= '' and exepath or nil
            end

            local function is_server_available(server_config)
                return server_config
                    and server_config.cmd
                    and server_config.cmd[1]
                    and vim.fn.executable(server_config.cmd[1]) == 1
            end

            local function on_attach(_, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
                    vim.lsp.buf.format { async = true }
                end, { desc = 'Format buffer with LSP' })

                local opts = { buffer = bufnr }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>la', function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set('n', '<leader>lr', function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set(
                    'n',
                    '<leader>ls',
                    vim.lsp.buf.signature_help,
                    opts
                )
                vim.keymap.set('n', '<leader>ld', function()
                    vim.diagnostic.open_float { scope = 'line' }
                end, opts)
            end

            local servers = {

                -- Lua
                lua_ls = {
                    cmd = { get_bin 'lua-language-server' },
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim', 'setup', 'util' },
                            },
                            telemetry = { enable = false },
                            runtime = { version = 'LuaJIT' },
                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file(
                                    '',
                                    true
                                ),
                            },
                            hint = {
                                enable = true,
                                arrayIndex = 'Disable',
                            },
                            codelens = { enable = true },
                        },
                    },
                },

                -- C/C++
                clangd = {
                    cmd = { get_bin 'clangd' },
                    settings = {
                        clangd = {
                            arguments = {
                                '--background-index',
                                '--clang-tidy',
                                '--header-insertion=iwyu',
                                '--completion-style=detailed',
                                '--function-arg-placeholders',
                                '--fallback-style=llvm',
                                '--stdlib=libc++',
                            },
                            fallbackStyle = 'llvm',
                            usePlaceholders = true,
                            completeUnimported = true,
                            semanticHighlighting = true,
                        },
                    },
                    filetypes = {
                        'c',
                        'cpp',
                        'objc',
                        'objcpp',
                        'cuda',
                        'proto',
                    },
                    root_dir = function(fname)
                        return require('lspconfig.util').root_pattern(
                            'compile_commands.json',
                            'compile_flags.txt',
                            '.git',
                            'CMakeLists.txt'
                        )(fname) or vim.fn.getcwd()
                    end,
                },

                -- Rust
                rust_analyzer = {
                    cmd = { get_bin 'rust-analyzer' },
                    settings = {
                        ['rust-analyzer'] = {
                            checkOnSave = {
                                command = 'clippy',
                                extraArgs = { '--no-deps' },
                            },
                            diagnostics = {
                                disabled = { 'unresolved-macro' },
                            },
                            cargo = {
                                autoreload = true,
                                buildScripts = {
                                    enable = true,
                                },
                                features = 'all',
                            },
                            procMacro = {
                                enable = true,
                            },
                            workspace = {
                                symbol = {
                                    search = {
                                        scope = 'workspace_and_dependencies',
                                    },
                                },
                            },
                        },
                    },
                    root_dir = function(fname)
                        return require('lspconfig.util').root_pattern(
                            'Cargo.toml',
                            'rust-project.json'
                        )(fname) or vim.fn.getcwd()
                    end,
                },

                -- Python
                ruff = {
                    cmd = { get_bin 'ruff', 'server' },
                    filetypes = { 'python' },
                    root_dir = function(fname)
                        return require('lspconfig.util').root_pattern(
                            'pyproject.toml',
                            'requirements.txt',
                            '.git',
                            'ruff.toml',
                            'setup.py'
                        )(fname) or vim.fn.getcwd()
                    end,
                    init_options = {
                        settings = {
                            lint = {
                                enable = true,
                                -- Add rule exceptions if needed
                                -- select = ["E", "F", "W"],
                                -- ignore = ["E501"],
                            },
                            format = {
                                enable = false,
                            },
                        },
                    },
                },

                -- Typescript
                ts_ls = {
                    cmd = { get_bin 'typescript-language-server', '--stdio' },
                    settings = {
                        tsserver = {
                            enable = true,
                        },
                    },
                },

                -- Markdown
                marksman = {
                    cmd = { get_bin 'marksman', 'server' },
                    settings = {
                        markdown = {
                            lint = {
                                enabled = true,
                                validateReferences = true,
                                validateLinks = true,
                            },
                        },
                    },
                },

                -- Nix
                nil_ls = {
                    cmd = { get_bin 'nil', '--stdio' },
                    settings = {
                        ['nil'] = {
                            formatting = { command = { 'nixpkgs-fmt' } },
                            diagnostics = { ignored = { 'unused_binding' } },
                        },
                    },
                },

                -- Shell (Bash, Zsh, Sh)
                bashls = {
                    cmd = { get_bin 'bash-language-server', 'start' },
                    settings = {
                        bash = {
                            diagnostics = {
                                enable = true,
                                globbing = 'warn',
                            },
                        },
                    },
                },

                -- YAML
                yamlls = {
                    cmd = { get_bin 'yaml-language-server', '--stdio' },
                    settings = {
                        yaml = {
                            schemas = {
                                kubernetes = '/*.yaml',
                            },
                            validate = true,
                            format = { enable = true },
                        },
                    },
                },

                -- Docker
                dockerls = {
                    cmd = { get_bin 'docker-language-server', '--stdio' },
                    filetypes = { 'dockerfile' },
                    root_dir = lsp.util.root_pattern('Dockerfile', '.git'),
                },

                -- TOML (taplo with formatting)
                taplo = {
                    cmd = { get_bin 'taplo', 'lsp', 'stdio' },
                    settings = {
                        toml = {
                            format = { enable = true },
                            diagnostics = { enabled = true },
                        },
                    },
                },
            }

            for server, config in pairs(servers) do
                if config and is_server_available(config) then
                    lsp[server].setup(vim.tbl_deep_extend('force', {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        flags = { debounce_text_changes = 150 },
                    }, config))
                else
                    vim.notify(
                        string.format('LSP server %s not installed', server),
                        vim.log.levels.WARN
                    )
                end
            end
        end,
    },
}
