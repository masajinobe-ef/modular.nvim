require('lazy').setup({

    -- Colorscheme
    require 'modular/plugins/colorscheme/cyberdream',

    -- Completions
    require 'modular/plugins/comp/nvim-cmp',
    require 'modular/plugins/comp/nvim-autopairs',
    require 'modular/plugins/comp/nvim-ts-autotag',

    -- Linting/Formatting
    require 'modular/plugins/lint-format/nvim-lint',
    require 'modular/plugins/lint-format/nvim-lspconfig',
    require 'modular/plugins/lint-format/conform-nvim',

    -- Syntax highlights
    require 'modular/plugins/syntax/nvim-colorizer',
    require 'modular/plugins/syntax/nvim-treesitter',
    require 'modular/plugins/syntax/todo-comments',

    -- UI
    require 'modular/plugins/ui/neo-tree',
    require 'modular/plugins/ui/gitsigns',
    require 'modular/plugins/ui/which-key',
    require 'modular/plugins/ui/lualine',
    -- require 'modular/plugins/ui/bufferline',
    require 'modular/plugins/ui/indent-blankline',

    -- Util
    require 'modular/plugins/util/harpoon',
    require 'modular/plugins/util/comment',
    require 'modular/plugins/util/telescope',
    require 'modular/plugins/util/mini',
    require 'modular/plugins/util/misc',
    require 'modular/plugins/util/better-escape',
    require 'modular/plugins/util/auto-save',
    require 'modular/plugins/util/neogit',
}, {
    ui = {
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})
