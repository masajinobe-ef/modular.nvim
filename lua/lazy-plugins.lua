require('lazy').setup({
    -- Util
    -- require 'modular/plugins/util/neogit',
    require 'modular/plugins/util/trouble',
    require 'modular/plugins/util/harpoon',
    require 'modular/plugins/util/telescope',
    require 'modular/plugins/util/better-escape',
    require 'modular/plugins/util/auto-save',
    require 'modular/plugins/util/mini',
    require 'modular/plugins/util/misc',
    require 'modular/plugins/util/flash',
    -- UI
    require 'modular/plugins/ui/cyberdream',
    require 'modular/plugins/ui/neo-tree',
    require 'modular/plugins/ui/gitsigns',
    require 'modular/plugins/ui/which-key',
    require 'modular/plugins/ui/lualine',
    -- Syntax
    require 'modular/plugins/syntax/nvim-treesitter',
    require 'modular/plugins/syntax/todo-comments',
    -- LSP
    require 'modular/plugins/lsp/nvim-lspconfig',
    -- Completions
    require 'modular/plugins/comp/nvim-cmp',
    require 'modular/plugins/comp/nvim-ts-autotag',
    require 'modular/plugins/comp/nvim-autopairs',
    -- Linting
    require 'modular/plugins/lint/nvim-lint',
    -- Formatting
    require 'modular/plugins/format/conform',
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
