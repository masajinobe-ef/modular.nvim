-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup(
    'kickstart-highlight-yank',
    { clear = true }
  ),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Lazy autoupdate
-- local function augroup(name)
--   return vim.api.nvim_create_augroup('lazyvim_' .. name, { clear = true })
-- end
--
-- vim.api.nvim_create_autocmd('VimEnter', {
--   desc = 'Lazy autoupdate',
--   group = augroup 'autoupdate',
--   callback = function()
--     require('lazy').update { show = false }
--   end,
-- })
