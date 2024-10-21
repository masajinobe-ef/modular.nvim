return {
    { -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        version = '*',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote

            require('mini.ai').setup {
                custom_textobjects = nil,
                mappings = {
                    -- Main textobject prefixes
                    around = 'a',
                    inside = 'i',

                    -- Next/last variants
                    around_next = 'an',
                    inside_next = 'in',
                    around_last = 'al',
                    inside_last = 'il',

                    -- Move cursor to corresponding edge of `a` textobject
                    goto_left = 'g[',
                    goto_right = 'g]',
                },

                n_lines = 50,
                search_method = 'cover_or_next',
                silent = false,
            }

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require('mini.surround').setup {
                custom_surroundings = nil,
                highlight_duration = 500,

                mappings = {
                    add = 'sa', -- Add surrounding in Normal and Visual modes
                    delete = 'sd', -- Delete surrounding
                    find = 'sf', -- Find surrounding (to the right)
                    find_left = 'sF', -- Find surrounding (to the left)
                    highlight = 'sh', -- Highlight surrounding
                    replace = 'sr', -- Replace surrounding
                    update_n_lines = 'sn', -- Update `n_lines`

                    suffix_last = 'l', -- Suffix to search with "prev" method
                    suffix_next = 'n', -- Suffix to search with "next" method
                },

                n_lines = 20,
                respect_selection_type = false,
                search_method = 'cover',
                silent = false,
            }
        end,
    },
}
