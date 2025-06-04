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
                        },
                    },
                },

                -- pyright = {
                --     cmd = { get_bin 'pyright-langserver', '--stdio' },
                --     before_init = function(_, config)
                --         local root_dir = config.root_dir
                --         local uv_venv_path = nil
                --
                --         local uv_toml = io.open(root_dir .. '/uv.toml')
                --         if uv_toml then
                --             uv_toml:close()
                --             local handle = io.popen('uv venv --path 2>/dev/null')
                --             if handle then
                --                 local result = handle:read('*a'):gsub('%s+', '')
                --                 handle:close()
                --                 if result ~= '' and vim.fn.isdirectory(result) == 1 then
                --                     uv_venv_path = result
                --                 end
                --             end
                --         end
                --
                --         if not uv_venv_path then
                --             local uv_paths = {
                --                 root_dir .. '/.venv',
                --                 root_dir .. '/.uv-venv',
                --                 root_dir .. '/.uv/.venv',
                --                 root_dir .. '/venv',
                --             }
                --             for _, path in ipairs(uv_paths) do
                --                 if vim.fn.isdirectory(path) == 1 then
                --                     uv_venv_path = path
                --                     break
                --                 end
                --             end
                --         end
                --
                --         if not uv_venv_path then
                --             local nix_python = vim.fn.system(
                --                 'nix-shell --run "which python" 2>/dev/null'
                --             ):gsub('%s+', '')
                --             if nix_python ~= '' and vim.fn.executable(nix_python) == 1 then
                --                 config.settings.python = {
                --                     pythonPath = nix_python,
                --                     analysis = {
                --                         autoSearchPaths = true,
                --                         useLibraryCodeForTypes = true,
                --                     }
                --                 }
                --                 return
                --             end
                --         end
                --
                --         if uv_venv_path then
                --             config.settings.python = config.settings.python or {}
                --             config.settings.python.pythonPath = uv_venv_path .. '/bin/python'
                --
                --             config.settings.python.analysis = config.settings.python.analysis or {}
                --             config.settings.python.analysis.venvPath = vim.fn.fnamemodify(uv_venv_path, ':h')
                --             config.settings.python.analysis.venv = vim.fn.fnamemodify(uv_venv_path, ':t')
                --
                --             local site_packages = uv_venv_path .. '/lib/python*/site-packages'
                --             config.settings.python.analysis.extraPaths = { site_packages }
                --         end
                --     end,
                --
                --     settings = {
                --         python = {
                --             analysis = {
                --                 typeCheckingMode = "basic",
                --                 diagnosticMode = "workspace",
                --                 autoSearchPaths = true,
                --                 useLibraryCodeForTypes = true,
                --                 -- diagnosticSeverityOverrides = {
                --                 --     reportUnusedVariable = "error",
                --                 --     reportUnusedImport = "error",
                --                 --     reportMissingImports = "error",
                --                 --     reportUndefinedVariable = "error",
                --                 --     reportUnboundVariable = "error",
                --                 --     reportDuplicateImport = "error",
                --                 --     reportOptionalMemberAccess = "none",
                --                 --     reportPrivateImportUsage = "none",
                --                 --     reportMissingTypeStubs = "none",
                --                 -- },
                --             },
                --         },
                --     },
                --     filetypes = { "python" },
                --     root_dir = function(fname)
                --         return require('lspconfig.util').root_pattern(
                --             'uv.toml', 'pyproject.toml', 'setup.py', 'requirements.txt', '.git'
                --         )(fname) or vim.fn.getcwd()
                --     end,
                -- },

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
                            lint = true,
                        },
                    },
                },

                -- Nix
                nil_ls = {
                    cmd = { get_bin 'nil', '--stdio' },
                    settings = {
                        ['nil'] = {
                            formatting = {
                                command = 'diagnostics',
                            },
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
                            },
                        },
                    },
                },

                -- yamlls = {
                --     cmd = { get_bin 'yaml-language-server', '--stdio' },
                --     -- settings = {
                --     --     yaml = {
                --     --         schemas = {},
                --     --         validate = true,
                --     --     },
                --     -- },
                -- },

                -- dockerls = {
                --     cmd = { get_bin 'dockerfile-language-server', '--stdio' },
                --     -- settings = {
                --     --     dockerfile = {
                --     --         lint = true,
                --     --     },
                --     -- },
                -- },

                -- taplo = {
                --     cmd = { get_bin 'taplo', 'lsp' },
                --     -- settings = {
                --     --     toml = {
                --     --         format = {
                --     --             enable = true,
                --     --         },
                --     --     },
                --     -- },
                -- },

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
