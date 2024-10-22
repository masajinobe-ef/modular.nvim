return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require 'harpoon'

            harpoon:setup()

            local conf = require('telescope.config').values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require('telescope.pickers')
                    .new({}, {
                        prompt_title = 'Harpoon',
                        finder = require('telescope.finders').new_table {
                            results = file_paths,
                        },
                        previewer = conf.file_previewer {},
                        sorter = conf.generic_sorter {},
                    })
                    :find()
            end

            vim.keymap.set('n', '<leader>h', function()
                toggle_telescope(harpoon:list())
            end, { desc = 'Toggle [h]arpoon quick menu' })
            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end, { desc = '[a]dd current file to Harpoon' })

            vim.keymap.set('n', '<C-1>', function()
                harpoon:list():select(1)
            end, { desc = '[1] select first Harpoon file' })
            vim.keymap.set('n', '<C-2>', function()
                harpoon:list():select(2)
            end, { desc = '[2] select second Harpoon file' })
            vim.keymap.set('n', '<C-3>', function()
                harpoon:list():select(3)
            end, { desc = '[3] select third Harpoon file' })
            vim.keymap.set('n', '<C-4>', function()
                harpoon:list():select(4)
            end, { desc = '[4] select fourth Harpoon file' })

            vim.keymap.set('n', '<C-S-P>', function()
                harpoon:list():prev()
            end, { desc = 'go to [P]revious Harpoon file' })
            vim.keymap.set('n', '<C-S-N>', function()
                harpoon:list():next()
            end, { desc = 'go to [N]ext Harpoon file' })
        end,
    },
}
