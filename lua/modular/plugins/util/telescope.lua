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
            { 'debugloop/telescope-undo.nvim' },
        },
        config = function()
            local actions = require 'telescope.actions'
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-l>'] = actions.select_default,
                        },
                        n = {
                            ['q'] = actions.close,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        file_ignore_patterns = {
                            'node_modules',
                            '.git',
                            '.venv',
                        },
                        hidden = true,
                    },
                    buffers = {
                        initial_mode = 'normal',
                        sort_lastused = true,
                        -- sort_mru = true,
                        mappings = {
                            n = {
                                ['d'] = actions.delete_buffer,
                                ['l'] = actions.select_default,
                            },
                        },
                    },
                },
                live_grep = {
                    file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                    additional_args = function(_)
                        return { '--hidden' }
                    end,
                },
                path_display = {
                    filename_first = {
                        reverse_directories = true,
                    },
                },
                git_files = {
                    previewer = false,
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                    ['undo'] = {},
                },
            }
            -- Enable Telescope extensions if they are installed
            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'undo')
            -- See `:help telescope.builtin`
            local builtin = require 'telescope.builtin'
            vim.keymap.set(
                'n',
                '<leader>u',
                '<cmd>Telescope undo<cr>',
                { desc = 'Telescope: Undo Tree' }
            )
            vim.keymap.set(
                'n',
                '<leader>sk',
                builtin.keymaps,
                { desc = 'Telescope: Keymaps' }
            )
            vim.keymap.set(
                'n',
                '<leader>sf',
                builtin.find_files,
                { desc = 'Telescope: Files' }
            )
            -- vim.keymap.set(
            --     'n',
            --     '<leader>ss',
            --     builtin.builtin,
            --     { desc = 'Telescope' }
            -- )
            vim.keymap.set(
                'n',
                '<leader>sw',
                builtin.grep_string,
                { desc = 'Telescope: Word' }
            )
            vim.keymap.set(
                'n',
                '<leader>sg',
                builtin.live_grep,
                { desc = 'Telescope: Grep' }
            )
            vim.keymap.set(
                'n',
                '<leader>sd',
                builtin.diagnostics,
                { desc = 'Telescope: Diagnostics' }
            )
            -- vim.keymap.set(
            --     'n',
            --     '<leader>sr',
            --     builtin.resume,
            --     { desc = 'Resume' }
            -- )
            -- vim.keymap.set(
            --     'n',
            --     '<leader>s.',
            --     builtin.oldfiles,
            --     { desc = 'Recent Files' }
            -- )
            vim.keymap.set(
                'n',
                '<leader>s<leader>',
                builtin.buffers,
                { desc = 'Telescope: Find Existing Buffers' }
            )
            -- slightly advanced example of overriding default behavior and theme
            vim.keymap.set('n', '<leader>s/', function()
                -- you can pass additional configuration to telescope to change the theme, layout, etc.
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
            end, { desc = 'Telescope: Fuzzily Search in Buffer' })

            -- it's also possible to pass additional configuration options.
            --  see `:help telescope.builtin.live_grep()` for information about particular keys
            -- vim.keymap.set('n', '<leader>s/', function()
            --     builtin.live_grep {
            --         grep_open_files = true,
            --         prompt_title = 'live grep in open files',
            --     }
            -- end, { desc = 'Grep in Open Files' })

            -- shortcut for searching your neovim configuration files
            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = 'Telescope: Neovim Files' })
        end,
    },
}
