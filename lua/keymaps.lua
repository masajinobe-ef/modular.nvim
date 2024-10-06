-- Function to show notification after action
local function notify_action(action_desc)
    vim.notify = require 'notify'
    vim.notify(action_desc .. ' ', vim.log.levels.INFO)
end

-- [[ Basic Keymaps ]]

-- -----------------------------
-- Terminal Management
-- -----------------------------

vim.keymap.set(
    'n',
    '<leader>tv',
    ':ToggleTerm direction=vertical<CR>',
    { noremap = true, silent = true, desc = 'Terminal: Vertical' }
)
vim.keymap.set(
    'n',
    '<leader>th',
    ':ToggleTerm direction=horizontal<CR>',
    { noremap = true, silent = true, desc = 'Terminal: Horizontal' }
)

-- -----------------------------
-- File Management
-- -----------------------------

-- Save file with notification
vim.keymap.set('n', '<C-s>', function()
    vim.cmd 'w' -- Save file
    notify_action 'File saved' -- Notify after saving
end, { noremap = true, silent = true, desc = 'Save file' })

-- Quit Neovim
vim.keymap.set(
    'n',
    '<C-q>',
    '<cmd> q <CR>',
    { noremap = true, silent = true, desc = 'Quit Neovim' }
)

-- -----------------------------
-- Deleting and Searching
-- -----------------------------

-- Delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', {
    noremap = true,
    silent = true,
    desc = 'Delete character without copying',
})

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', {
    noremap = true,
    silent = true,
    desc = 'Search next occurrence and center',
})
vim.keymap.set('n', 'N', 'Nzzzv', {
    noremap = true,
    silent = true,
    desc = 'Search previous occurrence and center',
})

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set(
    'n',
    '<Esc>',
    '<cmd>nohlsearch<CR>',
    { noremap = true, silent = true, desc = 'Clear search highlights' }
)

-- -----------------------------
-- Scrolling
-- -----------------------------

-- Vertical scroll and center
vim.keymap.set(
    'n',
    '<C-d>',
    '<C-d>zz',
    { noremap = true, silent = true, desc = 'Scroll down and center' }
)
vim.keymap.set(
    'n',
    '<C-u>',
    '<C-u>zz',
    { noremap = true, silent = true, desc = 'Scroll up and center' }
)

-- -----------------------------
-- Window Management
-- -----------------------------

-- Resize with arrows
vim.keymap.set(
    'n',
    '<Up>',
    ':resize -2<CR>',
    { noremap = true, silent = true, desc = 'Resize window up' }
)
vim.keymap.set(
    'n',
    '<Down>',
    ':resize +2<CR>',
    { noremap = true, silent = true, desc = 'Resize window down' }
)
vim.keymap.set(
    'n',
    '<Right>',
    ':vertical resize -2<CR>',
    { noremap = true, silent = true, desc = 'Resize window right' }
)
vim.keymap.set(
    'n',
    '<Left>',
    ':vertical resize +2<CR>',
    { noremap = true, silent = true, desc = 'Resize window left' }
)

-- Split and manage windows
vim.keymap.set(
    'n',
    '<leader>v',
    '<C-w>v',
    { noremap = true, silent = true, desc = 'Split window vertically' }
)
vim.keymap.set(
    'n',
    '<leader>h',
    '<C-w>s',
    { noremap = true, silent = true, desc = 'Split window horizontally' }
)
vim.keymap.set(
    'n',
    '<leader>se',
    '<C-w>=',
    { noremap = true, silent = true, desc = 'Make split windows equal size' }
)
vim.keymap.set(
    'n',
    '<leader>sx',
    ':close<CR>',
    { noremap = true, silent = true, desc = 'Close current split window' }
)

-- Navigate between splits
vim.keymap.set(
    'n',
    '<S-k>',
    ':wincmd k<CR>',
    { noremap = true, silent = true, desc = 'Move to the window above' }
)
vim.keymap.set(
    'n',
    '<S-j>',
    ':wincmd j<CR>',
    { noremap = true, silent = true, desc = 'Move to the window below' }
)
vim.keymap.set(
    'n',
    '<S-h>',
    ':wincmd h<CR>',
    { noremap = true, silent = true, desc = 'Move to the window on the left' }
)
vim.keymap.set(
    'n',
    '<S-l>',
    ':wincmd l<CR>',
    { noremap = true, silent = true, desc = 'Move to the window on the right' }
)

-- -----------------------------
-- Tab Management
-- -----------------------------

vim.keymap.set(
    'n',
    '<leader>to',
    ':tabnew<CR>',
    { noremap = true, silent = true, desc = 'Open new tab' }
)
vim.keymap.set(
    'n',
    '<leader>tx',
    ':tabclose<CR>',
    { noremap = true, silent = true, desc = 'Close current tab' }
)
vim.keymap.set(
    'n',
    '<leader>tn',
    ':tabn<CR>',
    { noremap = true, silent = true, desc = 'Go to next tab' }
)
vim.keymap.set(
    'n',
    '<leader>tp',
    ':tabp<CR>',
    { noremap = true, silent = true, desc = 'Go to previous tab' }
)

-- -----------------------------
-- Visual Mode Keymaps
-- -----------------------------

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', {
    noremap = true,
    silent = true,
    desc = 'Stay in indent mode when shifting left',
})
vim.keymap.set('v', '>', '>gv', {
    noremap = true,
    silent = true,
    desc = 'Stay in indent mode when shifting right',
})

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', {
    noremap = true,
    silent = true,
    desc = 'Paste without losing last yanked text',
})

-- -----------------------------
-- Diagnostic Keymaps
-- -----------------------------

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
    noremap = true,
    silent = true,
    desc = 'Go to previous diagnostic message',
})
vim.keymap.set(
    'n',
    ']d',
    vim.diagnostic.goto_next,
    { noremap = true, silent = true, desc = 'Go to next diagnostic message' }
)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, {
    noremap = true,
    silent = true,
    desc = 'Open floating diagnostic message',
})
vim.keymap.set(
    'n',
    '<leader>q',
    vim.diagnostic.setloclist,
    { noremap = true, silent = true, desc = 'Open diagnostics list' }
)

-- -----------------------------
-- Buffer Management
-- -----------------------------

-- Navigate buffers
vim.keymap.set(
    'n',
    '<Tab>',
    ':bnext<CR>',
    { noremap = true, silent = true, desc = 'Go to next buffer' }
)
vim.keymap.set(
    'n',
    '<S-Tab>',
    ':bprevious<CR>',
    { noremap = true, silent = true, desc = 'Go to previous buffer' }
)

-- Close the current buffer
vim.keymap.set(
    'n',
    '<leader>x',
    ':Bdelete!<CR>',
    { noremap = true, silent = true, desc = 'Close current buffer' }
)

-- Close all buffers command
vim.api.nvim_create_user_command('BdeleteAll', function()
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if
            vim.api.nvim_buf_is_loaded(buf)
            and buf ~= vim.api.nvim_get_current_buf()
        then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    vim.api.nvim_buf_delete(vim.api.nvim_get_current_buf(), { force = true })
end, { desc = 'Close all buffers' })

vim.keymap.set(
    'n',
    '<leader>X',
    ':BdeleteAll<CR>',
    { noremap = true, silent = true, desc = 'Close all buffers' }
)
vim.keymap.set(
    'n',
    '<leader>b',
    '<cmd> new <CR>',
    { noremap = true, silent = true, desc = 'Open new buffer' }
)

-- -----------------------------
-- Neotree Management
-- -----------------------------

vim.keymap.set(
    'n',
    '<leader>e',
    ':Neotree toggle position=left<CR>',
    { noremap = true, silent = true, desc = 'Toggle file explorer' }
)
vim.keymap.set(
    'n',
    '<leader>ngs',
    ':Neotree float git_status<CR>',
    { noremap = true, silent = true, desc = 'Open git status window' }
)

-- -----------------------------
-- Formatting
-- -----------------------------

-- Formatting with Conform and notification
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
    vim.notify = require 'notify'
    vim.notify('Formatting', vim.log.levels.INFO)
end, { range = true })

vim.keymap.set(
    'n',
    '<leader>f',
    ':Format<CR>',
    { noremap = true, silent = true, desc = 'Open git status window' }
)

-- [[ Basic Autocommands ]]

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
