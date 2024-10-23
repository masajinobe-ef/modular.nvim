return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',

                build = 'make',

                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },

            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function()
            require('telescope').setup {
                -- You can put your default mappings / updates / etc. in here
                --  All the info you're looking for is in `:help telescope.setup()`
                --
                -- defaults = {
                --   mappings = {
                --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
                --   },
                -- },
                -- pickers = {}
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set(
                'n',
                '<leader>sk',
                builtin.keymaps,
                { desc = '[s]earch [k]eymaps' }
            )
            vim.keymap.set(
                'n',
                '<leader>sf',
                builtin.find_files,
                { desc = '[s]earch [f]iles' }
            )
            vim.keymap.set(
                'n',
                '<leader>ss',
                builtin.builtin,
                { desc = '[s]earch [s]elect telescope' }
            )
            vim.keymap.set(
                'n',
                '<leader>sw',
                builtin.grep_string,
                { desc = '[s]earch current [w]ord' }
            )
            vim.keymap.set(
                'n',
                '<leader>sg',
                builtin.live_grep,
                { desc = '[s]earch by [g]rep' }
            )
            vim.keymap.set(
                'n',
                '<leader>sd',
                builtin.diagnostics,
                { desc = '[s]earch [d]iagnostics' }
            )
            vim.keymap.set(
                'n',
                '<leader>sr',
                builtin.resume,
                { desc = '[s]earch [r]esume' }
            )
            vim.keymap.set(
                'n',
                '<leader>s.',
                builtin.oldfiles,
                { desc = '[s]earch recent files ("." for repeat)' }
            )
            vim.keymap.set(
                'n',
                '<leader><leader>',
                builtin.buffers,
                { desc = '[ ] find existing buffers' }
            )

            -- slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>/', function()
                -- you can pass additional configuration to telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
            end, { desc = '[/] fuzzily search in current buffer' })

            -- it's also possible to pass additional configuration options.
            --  see `:help telescope.builtin.live_grep()` for information about particular keys
            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'live grep in open files',
                }
            end, { desc = '[s]earch [/] in open files' })

            -- shortcut for searching your neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[s]earch [n]eovim files' })
        end,
    },
}
