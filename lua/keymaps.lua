-- [[ Basic Keymaps ]]

-- Terminal
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<CR>',
  { noremap = true, silent = true, desc = 'Terminal: Vertical' })
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<CR>',
  { noremap = true, silent = true, desc = 'Terminal: Horizontal' })

-- Save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save file' })

-- Save file without auto-formatting
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w <CR>',
  { noremap = true, silent = true, desc = 'Save file without auto-formatting' })

-- Quit
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit Neovim' })

-- Delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete character without copying' })

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true, desc = 'Scroll down and center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true, desc = 'Scroll up and center' })

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true, desc = 'Search next occurrence and center' })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true, desc = 'Search previous occurrence and center' })

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', { noremap = true, silent = true, desc = 'Resize window up' })
vim.keymap.set('n', '<Down>', ':resize +2<CR>', { noremap = true, silent = true, desc = 'Resize window down' })
vim.keymap.set('n', '<Right>', ':vertical resize -2<CR>', { noremap = true, silent = true, desc = 'Resize window right' })
vim.keymap.set('n', '<Left>', ':vertical resize +2<CR>', { noremap = true, silent = true, desc = 'Resize window left' })

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true, desc = 'Go to next buffer' })
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Go to previous buffer' })
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', { noremap = true, silent = true, desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', { noremap = true, silent = true, desc = 'Open new buffer' })

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>h', '<C-w>s', { noremap = true, silent = true, desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>se', '<C-w>=', { noremap = true, silent = true, desc = 'Make split windows equal size' })
vim.keymap.set('n', '<leader>xs', ':close<CR>', { noremap = true, silent = true, desc = 'Close current split window' })

-- Navigate between splits
vim.keymap.set('n', '<S-k>', ':wincmd k<CR>', { noremap = true, silent = true, desc = 'Move to the window above' })
vim.keymap.set('n', '<S-j>', ':wincmd j<CR>', { noremap = true, silent = true, desc = 'Move to the window below' })
vim.keymap.set('n', '<S-h>', ':wincmd h<CR>', { noremap = true, silent = true, desc = 'Move to the window on the left' })
vim.keymap.set('n', '<S-l>', ':wincmd l<CR>', { noremap = true, silent = true, desc = 'Move to the window on the right' })

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { noremap = true, silent = true, desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Close current tab' })
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { noremap = true, silent = true, desc = 'Go to next tab' })
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { noremap = true, silent = true, desc = 'Go to previous tab' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true, desc = 'Stay in indent mode when shifting left' })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true, desc = 'Stay in indent mode when shifting right' })

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true, desc = 'Paste without losing last yanked text' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
  { noremap = true, silent = true, desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
  { noremap = true, silent = true, desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float,
  { noremap = true, silent = true, desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
  { noremap = true, silent = true, desc = 'Open diagnostics list' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { noremap = true, silent = true, desc = 'Clear search highlights' })

-- [[ Basic Autocommands ]]

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Format on save with Conform
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
