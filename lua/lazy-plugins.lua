-- [[ Configure and install plugins ]]

require('lazy').setup({
  -- Colorscheme
  require 'kickstart/plugins/colorscheme/cyberdream',

  -- Complections
  require 'kickstart/plugins/complections/nvim-cmp',
  require 'kickstart/plugins/complections/nvim-autopairs',
  require 'kickstart/plugins/complections/nvim-ts-autotag',

  -- Linting/Formatting
  require 'kickstart/plugins/linting-formatting/none-ls',

  -- LSP
  require 'kickstart/plugins/lsp/nvim-lspconfig',

  -- Syntax highlights
  require 'kickstart/plugins/syntax-highlights/gitsigns',
  require 'kickstart/plugins/syntax-highlights/indent-blankline',
  require 'kickstart/plugins/syntax-highlights/nvim-colorizer',
  require 'kickstart/plugins/syntax-highlights/nvim-treesitter',
  require 'kickstart/plugins/syntax-highlights/todo-comments',

  -- UI
  require 'kickstart/plugins/ui/lualine',
  require 'kickstart/plugins/ui/neo-tree',
  require 'kickstart/plugins/ui/bufferline',
  require 'kickstart/plugins/ui/alpha-nvim',

  -- Util
  require 'kickstart/plugins/util/Comment',
  require 'kickstart/plugins/util/which-key',
  require 'kickstart/plugins/util/telescope',
  require 'kickstart/plugins/util/mini',
  require 'kickstart/plugins/util/misc',
  require 'kickstart/plugins/util/better-escape',
  require 'kickstart/plugins/util/toggleterm',

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
