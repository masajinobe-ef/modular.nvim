return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        show_start = false,
        show_end = false,
        show_exact_scope = false,
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#C678DD' })

      require('ibl').setup { indent = { highlight = { 'IndentBlanklineChar' } } }
    end,
  },
}
