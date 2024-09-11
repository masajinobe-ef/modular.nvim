-- [[ Configure and install plugins ]]

require('lazy').setup({
  -- Colorscheme
  require 'kickstart/plugins/colorscheme/cyberdream',

  -- Util
  require 'kickstart/plugins/util/which-key',
  require 'kickstart/plugins/util/telescope',
  require 'kickstart/plugins/util/misc',

  -- UI
  require 'kickstart/plugins/ui/mini',
  require 'kickstart/plugins/ui/gitsigns',
  require 'kickstart/plugins/ui/lualine',
  require 'kickstart/plugins/ui/neo-tree',
  require 'kickstart/plugins/ui/bufferline',
  --require 'kickstart/plugins/ui/indent-blankline',
  require 'kickstart/plugins/ui/alpha',

  -- LSP
  require 'kickstart/plugins/lsp/treesitter',
  require 'kickstart/plugins/lsp/nvim-cmp',
  require 'kickstart/plugins/lsp/nvim-lspconfig',

  -- Linting/Formatting
  require 'kickstart/plugins/lint-format/none-ls',

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
