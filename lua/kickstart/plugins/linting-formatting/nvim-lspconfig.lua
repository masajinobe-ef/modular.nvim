return {
    -- nvim-lspconfig setup
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            -- Automatically install LSPs and related tools
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by nvim-cmp
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- Setup diagnostic options
            vim.diagnostic.config {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = 'if_many',
                    prefix = '●',
                },
                severity_sort = true,
                signs = {
                    severity = {
                        [vim.diagnostic.severity.ERROR] = {
                            text = 'E',
                            texthl = 'DiagnosticError',
                        },
                        [vim.diagnostic.severity.WARN] = {
                            text = 'W',
                            texthl = 'DiagnosticWarn',
                        },
                        [vim.diagnostic.severity.HINT] = {
                            text = 'H',
                            texthl = 'DiagnosticHint',
                        },
                        [vim.diagnostic.severity.INFO] = {
                            text = 'I',
                            texthl = 'DiagnosticInfo',
                        },
                    },
                },
            }

            -- Setup LSP capabilities (for nvim-cmp)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if has_cmp then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            -- Configure LSP servers
            local servers = {
                ruff = {},
                rust_analyzer = {},
                gopls = {},
                dockerls = {},
                bashls = {},
                tailwindcss = {},
                ts_ls = {},
                html = { filetypes = { 'html', 'twig', 'hbs' } },
                cssls = {},
                yamlls = {},
                jsonls = {},
                sqlls = {},
                kotlin_language_server = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = {
                                callSnippet = 'Replace',
                            },
                            diagnostics = { disable = { 'missing-fields' } },
                        },
                    },
                },
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                pyflakes = { enabled = false },
                                pycodestyle = { enabled = false },
                                autopep8 = { enabled = false },
                                yapf = { enabled = false },
                                mccabe = { enabled = false },
                                pylsp_mypy = { enabled = false },
                                pylsp_black = { enabled = false },
                                pylsp_isort = { enabled = false },
                            },
                        },
                    },
                },
            }

            -- Function to setup LSP servers
            local lspconfig = require 'lspconfig'
            for server, config in pairs(servers) do
                lspconfig[server].setup(vim.tbl_extend('force', {
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        -- Here you can define keymaps or any additional LSP settings
                        local opts = { noremap = true, silent = true }
                        local buf_set_keymap = vim.api.nvim_buf_set_keymap
                        -- Sample keymap for LSP functionality
                        buf_set_keymap(
                            bufnr,
                            'n',
                            'gd',
                            '<cmd>lua vim.lsp.buf.definition()<CR>',
                            opts
                        )
                    end,
                }, config))
            end

            -- Setup mason and auto-install servers
            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = vim.tbl_keys(servers),
            }

            -- Setup fidget for LSP status updates
            require('fidget').setup {}
        end,
    },
}
