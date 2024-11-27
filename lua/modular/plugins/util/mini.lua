return {
    {
        'echasnovski/mini.comment',
        version = '*',
        config = function()
            require('mini.comment').setup {
                options = {
                    ignore_blank_line = false,
                    start_of_line = false,
                    pad_comment_parts = true,
                },
                mappings = {
                    comment = 'gc',
                    comment_line = 'gcc',
                    comment_visual = 'gc',
                    textobject = 'gc',
                },
                hooks = {
                    pre = function() end,
                    post = function() end,
                },
            }
        end,
    },
    {
        'echasnovski/mini.move',
        version = '*',
        config = function()
            require('mini.move').setup {
                mappings = {
                    left = '<C-h>',
                    right = '<C-l>',
                    down = '<C-j>',
                    up = '<C-k>',
                    line_left = '<S-h>',
                    line_right = '<S-l>',
                    line_down = '<S-j>',
                    line_up = '<S-k>',
                },
                options = {
                    reindent_linewise = true,
                },
            }
        end,
    },
    {
        'echasnovski/mini.jump',
        version = '*',
        config = function()
            require('mini.jump').setup {
                mappings = {
                    forward = 'f',
                    backward = 'F',
                    forward_till = 't',
                    backward_till = 'T',
                    repeat_jump = ';',
                },
                delay = {
                    highlight = 100,
                    idle_stop = 10000000,
                },
            }
        end,
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        config = function()
            require('mini.surround').setup {
                highlight_duration = 500,
                mappings = {
                    add = 'gsa', -- Add surrounding in Normal and Visual modes
                    delete = 'gsd', -- Delete surrounding
                    find = 'gsf', -- Find surrounding (to the right)
                    find_left = 'gsF', -- Find surrounding (to the left)
                    highlight = 'gsh', -- Highlight surrounding
                    replace = 'gsr', -- Replace surrounding
                    update_n_lines = 'gsn', -- Update `n_lines`
                },
                n_lines = 20,
                respect_selection_type = false,
                search_method = 'cover',
                silent = false,
            }
        end,
    },
    {
        'echasnovski/mini.hipatterns',
        version = '*',
        config = function()
            local hipatterns = require 'mini.hipatterns'
            hipatterns.setup {
                highlighters = {
                    fixme = {
                        pattern = '%f[%w]()FIXME()%f[%W]',
                        group = 'MiniHipatternsFixme',
                    },
                    hack = {
                        pattern = '%f[%w]()HACK()%f[%W]',
                        group = 'MiniHipatternsHack',
                    },
                    todo = {
                        pattern = '%f[%w]()TODO()%f[%W]',
                        group = 'MiniHipatternsTodo',
                    },
                    note = {
                        pattern = '%f[%w]()NOTE()%f[%W]',
                        group = 'MiniHipatternsNote',
                    },
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            }
        end,
    },
    {
        'echasnovski/mini.indentscope',
        version = '*',
        config = function()
            require('mini.indentscope').setup {
                draw = {
                    delay = 50,
                    -- animation = require("mini.indentscope").gen_animation.none()
                },
                mappings = {
                    object_scope = 'ii',
                    object_scope_with_border = 'ai',

                    goto_top = '[i',
                    goto_bottom = ']i',
                },
                options = {
                    border = 'both',
                    indent_at_cursor = true,
                    try_as_border = false,
                },
                symbol = '╎',
            }
        end,
    },
}
