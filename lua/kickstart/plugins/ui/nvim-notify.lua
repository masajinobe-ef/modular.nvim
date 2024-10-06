return {
    {
        'rcarriga/nvim-notify',
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                timeout = 500,
                max_width = 30,
                max_height = 5,
                background_colour = '#000000',
                render = 'compact',
                minimum_width = 10,
                top_down = false,
            }
        end,
    },
}
