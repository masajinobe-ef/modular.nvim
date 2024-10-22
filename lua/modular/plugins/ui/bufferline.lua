return {
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = {
            'moll/vim-bbye',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('bufferline').setup {
                options = {
                    mode = 'buffers',
                    themable = true,
                    numbers = 'ordinal',
                    close_command = 'bdelete! %d',
                    right_mouse_command = 'bdelete! %d',
                    left_mouse_command = 'buffer %d',
                    indicator = {
                        icon = '▎',
                        style = 'icon',
                    },
                    buffer_close_icon = '󰅖',
                    modified_icon = '●',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    max_name_length = 18,
                    max_prefix_length = 15,
                    truncate_names = true,
                    tab_size = 18,
                    color_icons = true,
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = true,
                    show_tab_indicators = true,
                    separator_style = 'thin',
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    sort_by = 'insert_after_current',
                },
            }
        end,
    },
}
