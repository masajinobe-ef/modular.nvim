return {
    {
        'pocco81/auto-save.nvim',
        lazy = false,
        config = function()
            require('auto-save').setup {
                enabled = true, -- Enable auto-save
                execution_message = {
                    message = function()
                        return 'Auto-saved at ' .. os.date '%H:%M:%S'
                    end,
                    dim = 0.0, -- Dim the message
                    cleaning_interval = 3000, -- Interval to clean messages
                },
                events = { 'InsertLeave', 'TextChanged' }, -- Events to trigger auto-save
                conditions = {
                    exists = true, -- Only save if the file exists
                    filetype_is_not = {}, -- List of filetypes to ignore
                    filename_is_not = {}, -- List of filenames to ignore
                    modifiable = true, -- Only save if the buffer is modifiable
                },
                write_all_buffers = false, -- Write all buffers on auto-save
                on_auto_save = function() -- Custom function on auto-save
                    print 'File auto-saved!'
                end,
            }
        end,
    },
}
