-- [[ Functions ]]

-- Show notification after action function
local function notify_action(action_desc)
    vim.notify = require 'notify'
    vim.notify(action_desc .. ' ', vim.log.levels.INFO)
end

-- Replace words function
local function replace_all()
    local replacement = vim.fn.input 'Replace with: '
    if replacement ~= '' then
        local current_word = vim.fn.expand '<cword>'
        local command = string.format('%%s/%s/%s/g', current_word, replacement)
        vim.cmd(command)
        print 'All substitutions done'
    else
        print 'No replacement provided'
    end
end

local function replace_each()
    local replacement = vim.fn.input 'Replace with: '
    if replacement ~= '' then
        local current_word = vim.fn.expand '<cword>'
        local command =
            string.format('%%s/%s/%s/gc', current_word, replacement)
        vim.cmd(command)
        print 'Substitution done'
    else
        print 'No replacement provided'
    end
end

-- [[ Keymaps ]]

-- -----------------------------
-- Replace words
-- -----------------------------

vim.keymap.set('n', '<leader>ra', replace_all, {
    noremap = true,
    silent = true,
    desc = '[r]eplace [a]ll words',
})

vim.keymap.set('n', '<leader>re', replace_each, {
    noremap = true,
    silent = true,
    desc = '[r]eplace [e]ach words with a confirmation',
})

-- -----------------------------
-- Terminal Management
-- -----------------------------

vim.keymap.set(
    'n',
    '<leader>tv',
    ':ToggleTerm direction=vertical<CR>',
    { noremap = true, silent = true, desc = '[t]erminal: [v]ertical' }
)
vim.keymap.set(
    'n',
    '<leader>th',
    ':ToggleTerm direction=horizontal<CR>',
    { noremap = true, silent = true, desc = '[t]erminal: [h]orizontal' }
)

-- -----------------------------
-- File Management
-- -----------------------------

-- Save file with notification
vim.keymap.set('n', '<leader>sf', function()
    vim.cmd 'w' -- Save file
    notify_action 'File saved' -- Notify after saving
end, { noremap = true, silent = true, desc = '[s]ave [f]ile' })

-- Quit Neovim
vim.keymap.set(
    'n',
    '<C-q>',
    '<cmd> q <CR>',
    { noremap = true, silent = true, desc = '[q]uit neovim' }
)

-- -----------------------------
-- Searching
-- -----------------------------

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', {
    noremap = true,
    silent = true,
    desc = 'search next occurrence and center',
})

vim.keymap.set('n', 'N', 'Nzzzv', {
    noremap = true,
    silent = true,
    desc = 'search previous occurrence and center',
})

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set(
    'n',
    '<Esc>',
    '<cmd>nohlsearch<CR>',
    { noremap = true, silent = true, desc = 'clear search highlights' }
)

-- -----------------------------
-- Deleting
-- -----------------------------

-- Delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', {
    noremap = true,
    silent = true,
    desc = 'delete character without copying',
})

-- -----------------------------
-- Scrolling
-- -----------------------------

-- Vertical scroll and center
vim.keymap.set(
    'n',
    '<C-d>',
    '<C-d>zz',
    { noremap = true, silent = true, desc = 'scroll down and center' }
)

vim.keymap.set(
    'n',
    '<C-u>',
    '<C-u>zz',
    { noremap = true, silent = true, desc = 'scroll up and center' }
)

-- -----------------------------
-- Window Management
-- -----------------------------

-- Resize with arrows
vim.keymap.set(
    'n',
    '<Up>',
    ':resize -2<CR>',
    { noremap = true, silent = true, desc = 'resize window up' }
)

vim.keymap.set(
    'n',
    '<Down>',
    ':resize +2<CR>',
    { noremap = true, silent = true, desc = 'resize window down' }
)

vim.keymap.set(
    'n',
    '<Right>',
    ':vertical resize -2<CR>',
    { noremap = true, silent = true, desc = 'resize window right' }
)

vim.keymap.set(
    'n',
    '<Left>',
    ':vertical resize +2<CR>',
    { noremap = true, silent = true, desc = 'resize window left' }
)

-- Split and manage windows
vim.keymap.set(
    'n',
    '<leader>sv',
    '<C-w>v',
    { noremap = true, silent = true, desc = '[s]plit window: [v]ertical' }
)

vim.keymap.set(
    'n',
    '<leader>sh',
    '<C-w>s',
    { noremap = true, silent = true, desc = '[s]plit window: [h]orizontal' }
)

vim.keymap.set('n', '<leader>se', '<C-w>=', {
    noremap = true,
    silent = true,
    desc = '[s]plit: [e]qual sizes of windows',
})

vim.keymap.set(
    'n',
    '<leader>sc',
    ':close<CR>',
    { noremap = true, silent = true, desc = '[s]plit: [c]lose' }
)

-- Navigate between splits
vim.keymap.set(
    'n',
    '<S-k>',
    ':wincmd k<CR>',
    { noremap = true, silent = true, desc = 'move to the window above' }
)
vim.keymap.set(
    'n',
    '<S-j>',
    ':wincmd j<CR>',
    { noremap = true, silent = true, desc = 'move to the window below' }
)
vim.keymap.set(
    'n',
    '<S-h>',
    ':wincmd h<CR>',
    { noremap = true, silent = true, desc = 'move to the window on the left' }
)
vim.keymap.set(
    'n',
    '<S-l>',
    ':wincmd l<CR>',
    { noremap = true, silent = true, desc = 'move to the window on the right' }
)

-- -----------------------------
-- Visual Mode Keymaps
-- -----------------------------

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', {
    noremap = true,
    silent = true,
    desc = 'stay in indent mode when shifting left',
})

vim.keymap.set('v', '>', '>gv', {
    noremap = true,
    silent = true,
    desc = 'stay in indent mode when shifting right',
})

-- -----------------------------
-- Clipboard
-- -----------------------------

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', {
    noremap = true,
    silent = true,
    desc = 'paste without losing last yanked text',
})

-- -----------------------------
-- Buffer Management
-- -----------------------------

-- Navigate buffers
vim.keymap.set(
    'n',
    '<Tab>',
    ':bnext<CR>',
    { noremap = true, silent = true, desc = '[Bufferline]: next buffer' }
)

vim.keymap.set(
    'n',
    '<S-Tab>',
    ':bprevious<CR>',
    { noremap = true, silent = true, desc = '[Bufferline]: previous buffer' }
)

-- Close the current buffer
vim.keymap.set(
    'n',
    '<leader>c',
    ':Bdelete!<CR>',
    { noremap = true, silent = true, desc = '[c]lose buffer' }
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
    '<leader>C',
    ':BdeleteAll<CR>',
    { noremap = true, silent = true, desc = '[C]lose all buffers' }
)

-- Open new buffer
vim.keymap.set(
    'n',
    '<leader>b',
    '<cmd> new <CR>',
    { noremap = true, silent = true, desc = 'open new [b]uffer' }
)

-- -----------------------------
-- Neotree Management
-- -----------------------------

vim.keymap.set(
    'n',
    '<leader>e',
    ':Neotree toggle position=left<CR>',
    { noremap = true, silent = true, desc = 'toggle file [e]xplorer' }
)

-- -----------------------------
-- Formatting
-- -----------------------------

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
    { noremap = true, silent = true, desc = '[f]ormat file' }
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
