return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup {
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗',
                    },
                },
            }
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    'ruff',
                    'rust_analyzer',
                    'gopls',
                    'html',
                    'jsonls',
                    'dockerls',
                    'bashls',
                    'ts_ls',
                    'tailwindcss',
                    'cssls',
                    'yamlls',
                    'sqlls',
                    'kotlin_language_server',
                    'lua_ls',
                },
            }
        end,
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require 'lspconfig'

            -- lspconfig.lua_ls.setup {
            --     settings = {
            --         Lua = {
            --             completion = {
            --                 callSnippet = 'Replace',
            --             },
            --             diagnostics = { disable = { 'missing-fields' } },
            --         },
            --     },
            -- }

            lspconfig.ruff.setup {
                settings = {
                    -- Add settings for ruff here
                },
            }

            lspconfig.rust_analyzer.setup {
                settings = {
                    -- Add settings for rust_analyzer here
                },
            }

            lspconfig.gopls.setup {
                settings = {
                    -- Add settings for gopls here
                },
            }

            lspconfig.dockerls.setup {
                settings = {
                    -- Add settings for dockerls here
                },
            }

            lspconfig.bashls.setup {
                settings = {
                    -- Add settings for bashls here
                },
            }

            lspconfig.tailwindcss.setup {
                settings = {
                    -- Add settings for tailwindcss here
                },
            }

            lspconfig.html.setup {
                filetypes = { 'html', 'twig', 'hbs' },
                settings = {
                    -- Add settings for html here
                },
            }

            lspconfig.cssls.setup {
                settings = {
                    -- Add settings for cssls here
                },
            }

            lspconfig.yamlls.setup {
                settings = {
                    -- Add settings for yamlls here
                },
            }

            lspconfig.jsonls.setup {
                settings = {
                    -- Add settings for jsonls here
                },
            }

            lspconfig.sqlls.setup {
                settings = {
                    -- Add settings for sqlls here
                },
            }

            lspconfig.kotlin_language_server.setup {
                settings = {
                    -- Add settings for kotlin_language_server here
                },
            }
        end,
    },

    {
        'hrsh7th/cmp-nvim-lsp',
        config = function()
            local cmp = require 'cmp'
            cmp.setup {
                sources = {
                    { name = 'nvim_lsp' },
                },
            }
        end,
    },
}
