return {
  'masajinobe-ef/suda.nvim',
  config = function()
    require('suda').setup {
      smart_edit = true,
    }
  end,
}
