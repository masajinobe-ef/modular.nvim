-- [[ Configure and install plugins ]]

--  To check the current status of your plugins, run
--    :Lazy

require('lazy').setup({

    -- Colorscheme
    require 'kickstart/plugins/colorscheme/cyberdream',

    -- Completions
    -- require 'kickstart/plugins/completions/nvim-cmp',
    -- require 'kickstart/plugins/completions/nvim-autopairs',
    -- require 'kickstart/plugins/completions/nvim-ts-autotag',

    -- Linting/Formatting
    require 'kickstart/plugins/linting-formatting/conform',
    -- require("kickstart/plugins/linting-formatting/nvim-lint"),
    -- require 'kickstart/plugins/linting-formatting/nvim-lspconfig',

    -- Syntax highlights
    require 'kickstart/plugins/syntax-highlights/nvim-colorizer',
    require 'kickstart/plugins/syntax-highlights/nvim-treesitter',
    require 'kickstart/plugins/syntax-highlights/todo-comments',

    -- UI
    require 'kickstart/plugins/ui/which-key',
    require 'kickstart/plugins/ui/gitsigns',
    require 'kickstart/plugins/ui/lualine',
    require 'kickstart/plugins/ui/neo-tree',
    require 'kickstart/plugins/ui/bufferline',
    require 'kickstart/plugins/ui/alpha-nvim',
    require 'kickstart/plugins/ui/telescope',

    -- Util
    require 'kickstart/plugins/util/mason',
    require 'kickstart/plugins/util/comment',
    require 'kickstart/plugins/util/mini',
    require 'kickstart/plugins/util/misc',
    require 'kickstart/plugins/util/better-escape',
    require 'kickstart/plugins/util/toggleterm',
    require 'kickstart/plugins/util/auto-save',

    -- Custom
    { import = 'custom/plugins' },
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
