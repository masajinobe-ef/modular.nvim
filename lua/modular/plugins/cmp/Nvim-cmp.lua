return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',

        {
            'dcampos/nvim-snippy',
            config = function()
                require('snippy').setup {
                    mappings = {
                        is = {
                            ['<Tab>'] = 'expand_or_advance',
                            ['<S-Tab>'] = 'previous',
                        },
                    },
                }
            end,
        },
        'dcampos/cmp-snippy',

        {
            'windwp/nvim-autopairs',
            event = 'InsertEnter',
            config = function()
                require('nvim-autopairs').setup {
                    check_ts = true,
                    ts_config = {
                        lua = { 'string' },
                        javascript = { 'template_string' },
                    },
                    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
                }
            end,
        },
        {
            'windwp/nvim-ts-autotag',
            config = function()
                require('nvim-ts-autotag').setup {
                    enable_close_on_slash = false,
                    filetypes = {
                        'html',
                        'xml',
                        'javascript',
                        'typescript',
                        'javascriptreact',
                        'typescriptreact',
                        'svelte',
                        'vue',
                        'tsx',
                        'jsx',
                        'rescript',
                        'php',
                    },
                }
            end,
        },
    },

    config = function()
        local cmp = require 'cmp'
        local snippy = require 'snippy'
        local kind_icons = {
            Text = '',
            Method = '',
            Function = '󰊕',
            Constructor = '',
            Field = '',
            Variable = '',
            Class = '',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '',
            Enum = '',
            Keyword = '',
            Snippet = '',
            Color = '',
            File = '',
            Reference = '',
            Folder = '',
            EnumMember = '',
            Constant = '',
            Struct = '',
            Event = '',
            Operator = '',
            TypeParameter = '',
        }

        cmp.setup {
            completion = {
                completeopt = 'menu,menuone,noinsert',
                keyword_length = 1,
            },

            mapping = cmp.mapping.preset.insert {
                ['<C-j>'] = cmp.mapping.select_next_item {
                    behavior = cmp.SelectBehavior.Select,
                },
                ['<C-k>'] = cmp.mapping.select_prev_item {
                    behavior = cmp.SelectBehavior.Select,
                },
                ['<CR>'] = cmp.mapping.confirm {
                    select = true,
                    behavior = cmp.ConfirmBehavior.Replace,
                },
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if snippy.can_expand_or_advance() then
                        snippy.expand_or_advance()
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if snippy.can_jump(-1) then
                        snippy.previous()
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },

            snippet = {
                expand = function(args)
                    require('snippy').expand_snippet(args.body)
                end,
            },

            sources = cmp.config.sources {
                { name = 'nvim_lsp', priority = 1000 },
                { name = 'snippy', priority = 750 },
                { name = 'nvim_lua', priority = 650 },
                { name = 'path', priority = 500 },
                {
                    name = 'buffer',
                    priority = 250,
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
            },

            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, item)
                    item.kind = string.format(
                        '%s %s',
                        kind_icons[item.kind] or '?',
                        item.kind
                    )
                    item.menu = ({
                        nvim_lsp = '[LSP]',
                        snippy = '[SNP]',
                        buffer = '[BUF]',
                        path = '[PATH]',
                        nvim_lua = '[LUA]',
                    })[entry.source.name] or string.upper(
                        entry.source.name
                    )

                    return item
                end,
            },

            experimental = {
                ghost_text = {
                    hl_group = 'Comment',
                },
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }

        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
}
