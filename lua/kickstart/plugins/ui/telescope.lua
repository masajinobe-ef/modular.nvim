return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
            },
            {
                'nvim-tree/nvim-web-devicons',
                enabled = vim.g.have_nerd_font,
            },
        },
        config = function()
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-h>'] = 'move_selection_previous',
                            ['<C-j>'] = 'move_selection_next',
                            ['<C-k>'] = 'move_selection_previous',
                            ['<C-l>'] = 'move_selection_next',
                        },
                        n = {
                            ['h'] = 'move_selection_previous',
                            ['j'] = 'move_selection_next',
                            ['k'] = 'move_selection_previous',
                            ['l'] = 'move_selection_next',
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
                },
                live_grep = {
                    file_ignore_patterns = { 'node_modules', '.git', '.venv' },
                    additional_args = function(_)
                        return { '--hidden' }
                    end,
                },
                extensions = {
                    ['ui-select'] = {
                        require('telescope.themes').get_dropdown(),
                    },
                },
            }

            pcall(require('telescope').load_extension, 'fzf')
            pcall(require('telescope').load_extension, 'ui-select')

            local builtin = require 'telescope.builtin'

            vim.keymap.set(
                'n',
                '<leader>sh',
                builtin.help_tags,
                { desc = '[s]earch [h]elp' }
            )
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
                { desc = '[s]earch [s]elect Telescope' }
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
                { desc = '[s]earch Recent Files ([.] for repeat)' }
            )
            vim.keymap.set(
                'n',
                '<leader><leader>',
                builtin.buffers,
                { desc = '[space] Find existing buffers' }
            )

            vim.keymap.set('n', '<leader>/', function()
                builtin.current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>s/', function()
                builtin.live_grep {
                    grep_open_files = true,
                    prompt_title = 'Live Grep in Open Files',
                }
            end, { desc = '[s]earch [/] in Open Files' })

            vim.keymap.set('n', '<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[s]earch [n]eovim files' })
        end,
    },
}
