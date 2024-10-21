require('lazy').setup({

    -- Colorscheme
    require 'kickstart/plugins/colorscheme/cyberdream',

    -- Completions
    require 'kickstart/plugins/comp/nvim-cmp',
    require 'kickstart/plugins/comp/nvim-autopairs',
    require 'kickstart/plugins/comp/nvim-ts-autotag',

    -- Linting/Formatting
    require 'kickstart/plugins/lint-format/nvim-lint',
    require 'kickstart/plugins/lint-format/nvim-lspconfig',
    require 'kickstart/plugins/lint-format/conform-nvim',

    -- Syntax highlights
    require 'kickstart/plugins/syntax/nvim-colorizer',
    require 'kickstart/plugins/syntax/nvim-treesitter',
    require 'kickstart/plugins/syntax/todo-comments',

    -- UI
    require 'kickstart/plugins/ui/neo-tree',
    require 'kickstart/plugins/ui/gitsigns',
    require 'kickstart/plugins/ui/which-key',
    require 'kickstart/plugins/ui/lualine',
    require 'kickstart/plugins/ui/bufferline',
    require 'kickstart/plugins/ui/alpha-nvim',
    require 'kickstart/plugins/ui/indent-blankline',

    -- Util
    require 'kickstart/plugins/util/comment',
    require 'kickstart/plugins/util/telescope',
    require 'kickstart/plugins/util/mini',
    require 'kickstart/plugins/util/misc',
    require 'kickstart/plugins/util/better-escape',
    require 'kickstart/plugins/util/auto-save',
    require 'kickstart/plugins/util/neogit',
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
