return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local harpoon = require 'harpoon'

            harpoon:setup {
                settings = {
                    save_on_toggle = false,
                    sync_on_ui_close = false,
                    key = function()
                        return vim.loop.cwd()
                    end,
                },
            }

            vim.keymap.set('n', '<leader>k', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, { desc = 'Harpoon: List' })

            vim.keymap.set('n', '<leader>a', function()
                harpoon:list():add()
            end, { desc = 'Harpoon: Add' })

            vim.keymap.set('n', '<leader>c', function()
                harpoon:list():remove()
            end, { desc = 'Harpoon: Clean' })

            vim.keymap.set('n', '<C-S-P>', function()
                harpoon:list():prev()
            end, { desc = 'Harpoon: Prev' })

            vim.keymap.set('n', '<C-S-N>', function()
                harpoon:list():next()
            end, { desc = 'Harpoon: Next' })
        end,
    },
}
