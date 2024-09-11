return {
  { -- High-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  { -- Autopairs
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('nvim-autopairs').setup {}
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
    },
  },

  { -- wakatime
    'wakatime/vim-wakatime', 
    lazy = false 
  },
  
  { -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  { -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },

  { -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
}
