return {
  { -- Comment.nvim
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
}
