return {
  { -- tokyonight theme
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      require('tokyonight').setup {
        style = 'night', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
        light_style = 'day', -- The theme is used when the background is set to light
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
      }

      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
