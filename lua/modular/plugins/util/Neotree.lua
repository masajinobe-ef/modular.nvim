return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
        {
            's1n7ax/nvim-window-picker',
            version = '2.*',
            config = function()
                require('window-picker').setup {
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        bo = {
                            filetype = {
                                'neo-tree',
                                'neo-tree-popup',
                                'notify',
                                'NvimTree',
                            },
                            buftype = { 'terminal', 'quickfix' },
                        },
                    },
                }
            end,
        },
    },

    config = function()
        for type, icon in pairs {
            Error = ' ',
            Warn = ' ',
            Info = ' ',
            Hint = '󰌵',
        } do
            vim.fn.sign_define(
                'DiagnosticSign' .. type,
                { text = icon, texthl = 'DiagnosticSign' .. type }
            )
        end

        require('neo-tree').setup {
            close_if_last_window = true,
            popup_border_style = 'rounded',
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            open_files_do_not_replace_types = { 'trouble', 'qf', 'Outline' },
            default_component_configs = {
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 2,
                    padding = 0,
                    with_markers = true,
                    indent_marker = '│',
                    last_indent_marker = '└',
                    highlight = 'NeoTreeIndentMarker',
                    expander_collapsed = '',
                    expander_expanded = '',
                    expander_highlight = 'NeoTreeExpander',
                },
                icon = {
                    folder_closed = '',
                    folder_open = '',
                    folder_empty = '󰜌',
                    folder_empty_open = '󰜌',
                    default = '*',
                    highlight = 'NeoTreeFileIcon',
                    provider = function(config, node)
                        if node.type == 'file' or node.type == 'terminal' then
                            local name = node:get_name()
                            local ext = vim.fn.fnamemodify(name, ':e')
                            local icon, hl =
                                require('nvim-web-devicons').get_icon(name, ext)

                            if not icon then
                                icon = config.default or '*'
                                hl = 'DevIconDefault'
                            end

                            return {
                                text = icon,
                                highlight = hl,
                            }
                        end
                    end,
                },
                modified = {
                    symbol = '[+] ',
                    highlight = 'NeoTreeModified',
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = 'NeoTreeFileName',
                },
                git_status = {
                    symbols = {
                        added = '✚',
                        modified = '',
                        deleted = '✖',
                        renamed = '󰁕',
                        untracked = '',
                        ignored = '',
                        unstaged = '󰄱',
                        staged = '',
                        conflict = '',
                    },
                },
                file_size = {
                    enabled = false,
                    required_width = 64,
                },
                last_modified = {
                    enabled = true,
                    required_width = 88,
                    format = '%Y-%m-%d %H:%M',
                },
                created = {
                    enabled = false,
                    required_width = 110,
                    format = '%Y-%m-%d',
                },
                symlink_target = {
                    enabled = false,
                    text_format = function(target)
                        return '➛ ' .. target
                    end,
                },
            },
            window = {
                position = 'left',
                width = 30,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ['<space>'] = 'toggle_node',
                    ['<2-LeftMouse>'] = 'open',
                    ['<cr>'] = 'open',
                    ['<esc>'] = 'cancel',
                    ['P'] = { 'toggle_preview', config = { use_float = true } },
                    ['l'] = 'open',
                    ['S'] = 'open_split',
                    ['s'] = 'open_vsplit',
                    ['t'] = 'open_tabnew',
                    ['w'] = 'open_with_window_picker',
                    ['C'] = 'close_node',
                    ['z'] = 'close_all_nodes',
                    ['a'] = { 'add', config = { show_path = 'relative' } },
                    ['A'] = 'add_directory',
                    ['d'] = 'delete',
                    ['r'] = 'rename',
                    ['y'] = 'copy_to_clipboard',
                    ['x'] = 'cut_to_clipboard',
                    ['p'] = 'paste_from_clipboard',
                    ['c'] = 'copy',
                    ['m'] = 'move',
                    ['q'] = 'close_window',
                    ['R'] = 'refresh',
                    ['?'] = 'show_help',
                    ['<'] = 'prev_source',
                    ['>'] = 'next_source',
                    ['i'] = 'show_file_details',
                    ['h'] = 'close_node',
                    ['/'] = 'noop',
                },
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false,
                    hide_by_name = {
                        'node_modules',
                        '.git',
                    },
                    never_show = { '.DS_Store', 'thumbs.db' },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = true,
                hijack_netrw_behavior = 'open_current',
                use_libuv_file_watcher = true,
                window = {
                    mappings = {
                        ['<bs>'] = 'navigate_up',
                        ['.'] = 'set_root',
                        ['H'] = 'toggle_hidden',
                        ['/'] = 'fuzzy_finder',
                        ['f'] = 'filter_on_submit',
                        ['<c-x>'] = 'clear_filter',
                        ['[g'] = 'prev_git_modified',
                        [']g'] = 'next_git_modified',
                    },
                },
            },
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                group_empty_dirs = true,
                show_unloaded = true,
            },
            git_status = {
                window = {
                    position = 'float',
                    mappings = {
                        ['A'] = 'git_add_all',
                        ['gu'] = 'git_unstage_file',
                        ['ga'] = 'git_add_file',
                        ['gr'] = 'git_revert_file',
                        ['gc'] = 'git_commit',
                        ['gp'] = 'git_push',
                        ['gg'] = 'git_commit_and_push',
                    },
                },
            },
        }

        vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<CR>', {
            desc = 'Toggle Explorer',
        })
        vim.keymap.set('n', '<leader>o', '<cmd>Neotree focus<CR>', {
            desc = 'Focus Explorer',
        })
    end,
}
