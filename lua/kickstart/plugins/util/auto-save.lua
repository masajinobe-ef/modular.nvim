return {
    {
        'pocco81/auto-save.nvim',
        lazy = false,
        config = function()
            require('auto-save').setup {
                enabled = true,
                execution_message = {
                    message = function()
                        return 'Auto-saved at ' .. os.date '%H:%M:%S'
                    end,
                    dim = 0.0,
                    cleaning_interval = 3000,
                },
                events = { 'InsertLeave', 'TextChanged' },
                conditions = {
                    exists = true,
                    filetype_is_not = {},
                    filename_is_not = {},
                    modifiable = true,
                },
                write_all_buffers = false,
                on_auto_save = function()
                    print 'File auto-saved!'
                end,
            }
        end,
    },
}
