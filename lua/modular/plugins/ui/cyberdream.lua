return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        transparent = true,
        italic_comments = true,
        hide_fillchars = false,
        terminal_colors = true,
        cache = true,
      }

      vim.cmd.colorscheme 'cyberdream'
    end,
  },
}
