return {
  { -- solarized-osaka theme
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      require('solarized-osaka').setup {
        transparent = true,
        terminal_colors = true,
      }

      vim.cmd.colorscheme 'solarized-osaka'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
