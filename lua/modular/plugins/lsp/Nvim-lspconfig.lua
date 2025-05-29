return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = true },
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local is_nixos = vim.fn.filereadable('/etc/NIXOS') == 1
            local lsp = require('lspconfig')
            local diag = vim.diagnostic

            diag.config({
                virtual_text = true,
                signs = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                -- virtual_lines = {
                --     only_current_line = false,
                --     highlight_whole_line = true,
                -- },
            })

            require('lsp_lines').setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if cmp_ok then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            else
                vim.notify('cmp_nvim_lsp not available, using basic capabilities', vim.log.levels.WARN)
            end

            local function get_bin(pkg)
                if is_nixos then
                    local handle = io.popen('command -v ' .. pkg .. ' 2>/dev/null')
                    if not handle then return nil end
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

            local servers = {
                bashls = { cmd = { get_bin('bash-language-server'), 'start' } },
                clangd = { cmd = { get_bin('clangd') } },
                gopls = { cmd = { get_bin('gopls') } },
                lua_ls = {
                    cmd = { get_bin('lua-language-server') },
                    settings = {
                        Lua = {
                            diagnostics = { globals = { 'vim', 'setup' } },
                            telemetry = { enable = false },
                            runtime = { version = 'LuaJIT' },
                            workspace = {
                                checkThirdParty = false,
                                library = vim.api.nvim_get_runtime_file('', true),
                            }
                        }
                    }
                },
                nil_ls = { cmd = { get_bin('nil') } },
                taplo = { cmd = { get_bin('taplo') } },
                yamlls = { cmd = { get_bin('yaml-language-server') } },
                ruff = { cmd = { get_bin('ruff'), 'server' } },
                ts_ls = { cmd = { get_bin('typescript-language-server'), '--stdio' } },
                rust_analyzer = { cmd = { get_bin('rust-analyzer') } },
            }

            local function on_attach(_, bufnr)
                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
                    vim.lsp.buf.format({ async = true })
                end, { desc = 'Format buffer with LSP' })

                local opts = { buffer = bufnr }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>la', function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set('n', '<leader>lr', function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set('n', '<leader>ls', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>ld', function()
                    vim.diagnostic.open_float({ scope = 'line' })
                end, opts)
                -- vim.keymap.set('n', '[d', function()
                --     vim.diagnostic.goto_prev({ float = { scope = 'line' } })
                -- end, opts)
                -- vim.keymap.set('n', ']d', function()
                --     vim.diagnostic.goto_next({ float = { scope = 'line' } })
                -- end, opts)
            end

            for server, config in pairs(servers) do
                if config and is_server_available(config) then
                    lsp[server].setup(vim.tbl_deep_extend('force', {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        flags = { debounce_text_changes = 150 },
                    }, config))
                else
                    vim.notify(string.format('LSP server %s not installed', server), vim.log.levels.WARN)
                end
            end
        end,
    },
}
