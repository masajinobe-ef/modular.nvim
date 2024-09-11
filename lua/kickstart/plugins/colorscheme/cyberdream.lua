return {
  { -- cyberdream theme
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      require('cyberdream').setup {
        transparent = true,
        terminal_colors = true,
      }

      vim.cmd.colorscheme 'cyberdream'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
