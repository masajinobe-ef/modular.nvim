return {
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  vim.keymap.set(
    'n',
    '<leader>T',
    '<cmd>ToggleTerm direction=float<CR>',
    { desc = 'Terminal' }
  ),
}
