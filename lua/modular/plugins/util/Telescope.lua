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
                    layout_strategy = 'horizontal',
                    layout_config = {
                        horizontal = { preview_width = 0.5 },
                    },
                    mappings = {
                        i = {
                            ['<C-u>'] = actions.move_selection_previous,
                            ['<C-d>'] = actions.move_selection_next,
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
                        hidden = false,
                    },
                    buffers = {
                        initial_mode = 'normal',
                        sort_lastused = false,
                        sort_mru = false,
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

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')
            pcall(require('telescope').load_extension, 'undo')

            local builtin = require 'telescope.builtin'

            vim.keymap.set(
                'n',
                '<leader>su',
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

            vim.keymap.set(
                'n',
                '<leader>s<leader>',
                builtin.buffers,
                { desc = 'Telescope: Find Existing Buffers' }
            )

            vim.keymap.set('n', '<leader>s/', function()
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
            end, { desc = 'Telescope: Fuzzily Search in Buffer' })

            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = 'Telescope: Neovim Files' })
        end,
    },
}
