return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = true },
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

            local capabilities = vim.tbl_deep_extend(
                'force',
                vim.lsp.protocol.make_client_capabilities(),
                require('cmp_nvim_lsp').default_capabilities()
            )

            local function get_nix_bin(pkg)
                if is_nixos then
                    local handle = io.popen('which ' .. pkg .. ' 2>/dev/null')
                    local result = handle:read('*a'):gsub('\n', '')
                    handle:close()
                    return result ~= '' and result or nil
                end
                return pkg
            end

            local nix_servers = {
                bashls = { cmd = { get_nix_bin 'bash-language-server', 'start' } },
                clangd = { cmd = { get_nix_bin 'clangd' } },
                gopls = { cmd = { get_nix_bin 'gopls' } },
                lua_ls = {
                    cmd = { get_nix_bin 'lua-language-server' },
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { 'vim' },
                            },
                            telemetry = { enable = false },
                            runtime = {
                                version = 'LuaJIT',
                                path = vim.split(package.path, ';')
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                }
                            }
                        }
                    }
                },
                nil_ls = { cmd = { get_nix_bin 'nil' } },
                taplo = { cmd = { get_nix_bin 'taplo' } },
                yamlls = { cmd = { get_nix_bin 'yaml-language-server' } },
                ruff = { cmd = { get_nix_bin 'ruff', 'server' } },
            }

            local function is_server_available(server_config)
                return server_config
                    and server_config.cmd
                    and server_config.cmd[1]
                    and vim.fn.executable(server_config.cmd[1]) == 1
            end

            vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
                pattern = '.env',
                command = 'set filetype=env',
            })

            local function setup_server(server, config)
                if not is_server_available(config) then
                    print('Server not available:', server)
                    return
                end

                lsp[server].setup(vim.tbl_deep_extend('force', {
                    capabilities = capabilities,
                    on_attach = function(_, bufnr)
                        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                            vim.lsp.buf.format()
                        end, { desc = 'Format current buffer with LSP' })
                    end,
                }, config))
            end

            for server, config in pairs(nix_servers) do
                if config then
                    setup_server(server, config)
                end
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>lh', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
                end,
            })
        end,
    },
}
