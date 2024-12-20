require('lazy').setup({
  -- Util
  require 'modular/plugins/util/Trouble',
  require 'modular/plugins/util/Harpoon',
  require 'modular/plugins/util/Telescope',
  require 'modular/plugins/util/Better-escape',
  require 'modular/plugins/util/Auto-save',
  require 'modular/plugins/util/Mini',
  require 'modular/plugins/util/Misc',
  require 'modular/plugins/util/Flash',
  require 'modular/plugins/util/Refactoring',
  require 'modular/plugins/util/Neotree',
  --require 'modular/plugins/util/Oil',
  -- UI
  require 'modular/plugins/ui/Rose-pine',
  require 'modular/plugins/ui/Gitsigns',
  require 'modular/plugins/ui/Which-key',
  require 'modular/plugins/ui/Lualine',
  -- Syntax
  require 'modular/plugins/syntax/Nvim-treesitter',
  require 'modular/plugins/syntax/Todo-comments',
  -- LSP
  require 'modular/plugins/lsp/Nvim-lspconfig',
  -- Completions
  require 'modular/plugins/comp/Nvim-cmp',
  require 'modular/plugins/comp/Nvim-ts-autotag',
  require 'modular/plugins/comp/Nvim-autopairs',
  -- Linting
  require 'modular/plugins/lint/Nvim-lint',
  -- Formatting
  require 'modular/plugins/format/Conform',
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
