return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',

        -- Snippets
        'rafamadriz/friendly-snippets',

        'echasnovski/mini.snippets',
        'abeldekat/cmp-mini-snippets',

        'dcampos/nvim-snippy',
        'dcampos/cmp-snippy',

        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },

    config = function()
        local kind_icons = {
            Text = '󰉿',
            Method = 'm',
            Function = '󰊕',
            Constructor = '',
            Field = '',
            Variable = '󰆧',
            Class = '󰌗',
            Interface = '',
            Module = '',
            Property = '',
            Unit = '',
            Value = '󰎠',
            Enum = '',
            Keyword = '󰌋',
            Color = '󰏘',
            File = '󰈙',
            Reference = '',
            Folder = '󰉋',
            EnumMember = '',
            Constant = '󰇽',
            Struct = '',
            Event = '',
            Operator = '󰆕',
            TypeParameter = '󰊄',
        }

        -- cmp
        local cmp = require 'cmp'
        cmp.setup {
            completion = { completeopt = 'menu,menuone,noinsert' },

            mapping = cmp.mapping.preset.insert {
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<CR>'] = cmp.mapping.confirm { select = true },
                ['<C-c>'] = cmp.mapping.complete {},
                ['<C-l>'] = cmp.mapping(function()
                end, { 'i', 's' }),

                ['<C-h>'] = cmp.mapping(function()
                end, { 'i', 's' }),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },

            snippet = {
                expand = function(args)
                end,
            },

            sources = {
                { name = 'nvim_lsp' },
                {
                    name = 'buffer', -- Exclude buffer source for gitcommit and yaml
                    filetypes = function(ft)
                        return not vim.tbl_contains(
                            { 'gitcommit', 'yaml', 'dockerfile' },
                            ft
                        )
                    end,
                },
                { name = 'path' },
            },

            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
                    vim_item.menu = ({
                        nvim_lsp = '[LSP]',
                        buffer = '[Buffer]',
                        path = '[Path]',
                    })[entry.source.name]
                    return vim_item
                end,
            },
        }
    end,
}
