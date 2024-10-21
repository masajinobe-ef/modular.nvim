-- Keymap options
local opts = { noremap = true, silent = true }

-- -----------------------------
-- [[ Lazy.nvim Plugin Manager ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<leader>l',
    ':Lazy<CR>',
    vim.tbl_extend('force', opts, { desc = 'open [l]azy plugin manager' })
)

-- -----------------------------
-- [[ Moving and Joining ]]
-- -----------------------------
vim.keymap.set(
    'v',
    'J',
    ":m '>+1<CR>gv=gv",
    vim.tbl_extend('force', opts, { desc = 'move selected lines down' })
)

vim.keymap.set(
    'v',
    'K',
    ":m '<-2<CR>gv=gv",
    vim.tbl_extend('force', opts, { desc = 'move selected lines up' })
)

vim.keymap.set(
    'n',
    'J',
    'mzJz',
    vim.tbl_extend('force', opts, { desc = 'join line with the next line' })
)

-- -----------------------------
-- [[ Clipboard Management ]]
-- -----------------------------
vim.keymap.set(
    'x',
    '<leader>p',
    [["_dP]],
    vim.tbl_extend(
        'force',
        opts,
        { desc = 'paste without overwriting clipboard' }
    )
)

vim.keymap.set(
    { 'n', 'v' },
    '<leader>d',
    [["_d]],
    vim.tbl_extend('force', opts, { desc = 'delete without yanking' })
)

vim.keymap.set(
    'v',
    'p',
    '"_dP',
    vim.tbl_extend(
        'force',
        opts,
        { desc = 'paste without losing last yanked text' }
    )
)

-- -----------------------------
-- [[ Neogit ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<leader>g',
    ':Neogit<CR>',
    vim.tbl_extend('force', opts, { desc = 'open neo[g]it' })
)

-- -----------------------------
-- [[ Replace ]]
-- -----------------------------
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

    local command =
        string.format('%%s/%s/%s/gc', escaped_search, escaped_replace)

    vim.cmd(command)
end, { desc = '[r]eplace word with confirmation' })

-- -----------------------------
-- [[ File Management ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<C-q>',
    '<cmd>q<CR>',
    vim.tbl_extend('force', opts, { desc = '[q]uit neovim' })
)

-- -----------------------------
-- [[ Searching ]]
-- -----------------------------
vim.keymap.set(
    'n',
    'n',
    'nzzzv',
    vim.tbl_extend(
        'force',
        opts,
        { desc = 'search next occurrence and center' }
    )
)

vim.keymap.set(
    'n',
    'N',
    'Nzzzv',
    vim.tbl_extend(
        'force',
        opts,
        { desc = 'search previous occurrence and center' }
    )
)

vim.keymap.set(
    'n',
    '<Esc>',
    '<cmd>nohlsearch<CR>',
    vim.tbl_extend('force', opts, { desc = 'clear search highlights' })
)

-- -----------------------------
-- [[ Diagnostic Management ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '[d',
    vim.diagnostic.goto_prev,
    vim.tbl_extend('force', opts, { desc = 'previous [d]iagnostic message' })
)

vim.keymap.set(
    'n',
    ']d',
    vim.diagnostic.goto_next,
    vim.tbl_extend('force', opts, { desc = 'next [d]iagnostic message' })
)

vim.keymap.set(
    'n',
    '<leader>d',
    vim.diagnostic.open_float,
    vim.tbl_extend('force', opts, { desc = 'show [d]iagnostic error message' })
)

vim.keymap.set(
    'n',
    '<leader>qd',
    vim.diagnostic.setloclist,
    vim.tbl_extend('force', opts, { desc = 'open diagnostic [q]uickfix list' })
)

-- -----------------------------
-- [[ Deleting ]]
-- -----------------------------
vim.keymap.set(
    'n',
    'x',
    '"_x',
    vim.tbl_extend('force', opts, { desc = 'delete character without copying' })
)

-- -----------------------------
-- [[ Scrolling ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<C-d>',
    '<C-d>zz',
    vim.tbl_extend('force', opts, { desc = 'scroll down and center' })
)

vim.keymap.set(
    'n',
    '<C-u>',
    '<C-u>zz',
    vim.tbl_extend('force', opts, { desc = 'scroll up and center' })
)

-- -----------------------------
-- [[ Window Management ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<Up>',
    ':resize -2<CR>',
    vim.tbl_extend('force', opts, { desc = 'resize window up' })
)

vim.keymap.set(
    'n',
    '<Down>',
    ':resize +2<CR>',
    vim.tbl_extend('force', opts, { desc = 'resize window down' })
)

vim.keymap.set(
    'n',
    '<Left>',
    ':vertical resize -2<CR>',
    vim.tbl_extend('force', opts, { desc = 'resize window left' })
)

vim.keymap.set(
    'n',
    '<Right>',
    ':vertical resize +2<CR>',
    vim.tbl_extend('force', opts, { desc = 'resize window right' })
)

vim.keymap.set(
    'n',
    '<leader>sv',
    '<C-w>v',
    vim.tbl_extend('force', opts, { desc = '[s]plit window: [v]ertical' })
)

vim.keymap.set(
    'n',
    '<leader>sh',
    '<C-w>s',
    vim.tbl_extend('force', opts, { desc = '[s]plit window: [h]orizontal' })
)

vim.keymap.set(
    'n',
    '<leader>se',
    '<C-w>=',
    vim.tbl_extend(
        'force',
        opts,
        { desc = '[s]plit: [e]qual sizes of windows' }
    )
)

vim.keymap.set(
    'n',
    '<leader>sc',
    ':close<CR>',
    vim.tbl_extend('force', opts, { desc = '[s]plit: [c]lose' })
)

vim.keymap.set(
    'n',
    '<S-h>',
    ':wincmd h<CR>',
    vim.tbl_extend('force', opts, { desc = 'move to the window on the left' })
)

vim.keymap.set(
    'n',
    '<S-l>',
    ':wincmd l<CR>',
    vim.tbl_extend('force', opts, { desc = 'move to the window on the right' })
)

-- -----------------------------
-- [[ Visual Mode Keymaps ]]
-- -----------------------------
vim.keymap.set(
    'v',
    '<',
    '<gv',
    vim.tbl_extend(
        'force',
        opts,
        { desc = 'stay in indent mode when shifting left' }
    )
)

vim.keymap.set(
    'v',
    '>',
    '>gv',
    vim.tbl_extend(
        'force',
        opts,
        { desc = 'stay in indent mode when shifting right' }
    )
)

-- -----------------------------
-- [[ Buffer Management ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<Tab>',
    ':bnext<CR>',
    vim.tbl_extend('force', opts, { desc = '[Bufferline]: next buffer' })
)

vim.keymap.set(
    'n',
    '<S-Tab>',
    ':bprevious<CR>',
    vim.tbl_extend('force', opts, { desc = '[Bufferline]: previous buffer' })
)

vim.keymap.set(
    'n',
    '<leader>x',
    ':Bdelete!<CR>',
    vim.tbl_extend('force', opts, { desc = '[x] close buffer' })
)

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
end, { desc = '[X] close all buffers' })

vim.keymap.set(
    'n',
    '<leader>X',
    ':BdeleteAll<CR>',
    vim.tbl_extend('force', opts, { desc = '[X] close all buffers' })
)

vim.keymap.set(
    'n',
    '<leader>b',
    '<cmd>new<CR>',
    vim.tbl_extend('force', opts, { desc = 'open new [b]uffer' })
)

-- -----------------------------
-- [[ Neotree Management ]]
-- -----------------------------
vim.keymap.set(
    'n',
    '<leader>e',
    ':Neotree toggle position=left<CR>',
    vim.tbl_extend('force', opts, { desc = 'toggle file [e]xplorer' })
)

-- -----------------------------
-- [[ Formatting ]]
-- -----------------------------
vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range =
            { start = { args.line1, 0 }, ['end'] = { args.line2, #end_line } }
    end
    vim.lsp.buf.format { range = range }
end, { desc = 'Format the current buffer or selected lines', range = true })

vim.keymap.set(
    'n',
    '<leader>f',
    ':Format<CR>',
    vim.tbl_extend('force', opts, { desc = '[f]ormat manually' })
)

-- -----------------------------
-- [[ Misc ]]
-- -----------------------------
vim.keymap.set(
    'n',
    'Q',
    '<nop>',
    vim.tbl_extend('force', opts, { desc = 'Disable Q command' })
)

vim.keymap.set(
    'n',
    '<leader>mx',
    '<cmd>!chmod +x %<CR>',
    vim.tbl_extend('force', opts, { desc = 'Make current file executable' })
)
