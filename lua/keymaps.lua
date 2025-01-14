local opts = { noremap = true, silent = true }

-- [[ Lazy: Plugin Manager ]]
vim.keymap.set(
  'n',
  '<leader>L',
  '<cmd>Lazy<CR>',
  vim.tbl_extend('force', opts, { desc = 'Lazy: Plugin Manager' })
)

-- [[ Mason: Package Manager ]]
vim.keymap.set(
  'n',
  '<leader>M',
  '<cmd>Mason<CR>',
  vim.tbl_extend('force', opts, { desc = 'Mason: Package Manager' })
)

-- [[ Conform: Format ]]
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line =
      vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  require('conform').format {
    async = true,
    lsp_format = 'fallback',
    range = range,
  }
end, {
  desc = '[Modular] Format the current buffer or selected lines',
  range = true,
})

vim.keymap.set(
  'n',
  '<leader>f',
  '<cmd>Format<CR>',
  vim.tbl_extend('force', opts, { desc = 'Conform: Format' })
)

-- [[ Clipboard ]]
vim.keymap.set(
  'x',
  '<leader>p',
  [["_dP]],
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Paste without overwriting clipboard' }
  )
)

vim.keymap.set(
  { 'n', 'v' },
  '<leader>d',
  [["_d]],
  vim.tbl_extend('force', opts, { desc = 'Delete w/o yank' })
)

vim.keymap.set(
  'v',
  'p',
  '"_dP',
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Paste without losing last yanked text' }
  )
)

vim.keymap.set(
  'n',
  'x',
  '"_x',
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Delete character without copying' }
  )
)

-- [[ Replace word ]]
vim.keymap.set('n', '<leader>rw', function()
  local search_word = vim.fn.input 'Enter word to search: '
  if search_word == '' then
    print 'Search word cannot be empty.'
    return
  end

  local replace_word = vim.fn.input 'Enter word to replace: '
  if replace_word == '' then
    print 'Replace word cannot be empty.'
    return
  end

  local escaped_search = search_word:gsub('/', '\\/')
  local escaped_replace = replace_word:gsub('/', '\\/')

  local command = string.format('%%s/%s/%s/gc', escaped_search, escaped_replace)

  vim.cmd(command)
end, { desc = 'Replace word' })

-- [[ Searching ]]
vim.keymap.set(
  'n',
  'n',
  'nzzzv',
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Search next occurrence and center' }
  )
)

vim.keymap.set(
  'n',
  'N',
  'Nzzzv',
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Search previous occurrence and center' }
  )
)

vim.keymap.set(
  'n',
  '<Esc>',
  '<cmd>nohlsearch<CR>',
  vim.tbl_extend('force', opts, { desc = '[Modular] Clear search highlights' })
)

-- [[ Scrolling ]]
vim.keymap.set(
  'n',
  '<C-d>',
  '<C-d>zz',
  vim.tbl_extend('force', opts, { desc = '[Modular] Scroll down and center' })
)

vim.keymap.set(
  'n',
  '<C-u>',
  '<C-u>zz',
  vim.tbl_extend('force', opts, { desc = '[Modular] Scroll up and center' })
)

-- [[ Visual Mode ]]
vim.keymap.set(
  'v',
  '<',
  '<gv',
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Stay in indent mode when shifting left' }
  )
)

vim.keymap.set(
  'v',
  '>',
  '>gv',
  vim.tbl_extend(
    'force',
    opts,
    { desc = '[Modular] Stay in indent mode when shifting right' }
  )
)

-- [[ Misc ]]
vim.keymap.set(
  'n',
  '<leader>q',
  '<cmd>q<CR>',
  vim.tbl_extend('force', opts, { desc = 'Close' })
)

vim.keymap.set(
  'n',
  'q',
  '<nop>',
  vim.tbl_extend('force', opts, { desc = '[Modular] Disable q (macros)' })
)
