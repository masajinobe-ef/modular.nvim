-- Constants
local opts = { noremap = true, silent = true }
-------------------------------------------------------------------------------

-- Plugins Keymaps

-- [[ Lazy.nvim Plugin Manager ]]
vim.keymap.set(
    'n',
    '<leader>L',
    '<cmd>Lazy<CR>',
    vim.tbl_extend('force', opts, { desc = 'Lazy: Plugin Manager' })
)

-- [[ Mason Package Manager ]]
vim.keymap.set(
    'n',
    '<leader>M',
    '<cmd>Mason<CR>',
    vim.tbl_extend('force', opts, { desc = 'Mason: Package Manager' })
)

-- [[ Conform ]]
vim.api.nvim_create_user_command('Format', function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, #end_line },
        }
    end
    vim.lsp.buf.format { range = range }
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

vim.keymap.set(
    'n',
    '<leader>T',
    '<cmd>TodoTelescope<CR>',
    vim.tbl_extend('force', opts, { desc = 'ToDo: Comments' })
)

-------------------------------------------------------------------------------

-- Neovim Keymaps

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
    vim.tbl_extend('force', opts, { desc = 'Delete: without yanking' })
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

-- [[ Replace Words ]]
vim.keymap.set('n', '<leader>r', function()
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
end, { desc = 'Replace: Word' })

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
    vim.tbl_extend(
        'force',
        opts,
        { desc = '[Modular] Clear search highlights' }
    )
)

-- [[ Scrolling ]]
vim.keymap.set(
    'n',
    '<C-d>',
    '<C-d>zz',
    vim.tbl_extend(
        'force',
        opts,
        { desc = '[Modular] Scroll down and center' }
    )
)

vim.keymap.set(
    'n',
    '<C-u>',
    '<C-u>zz',
    vim.tbl_extend('force', opts, { desc = '[Modular] Scroll up and center' })
)

-- [[ Windows ]]
vim.keymap.set(
    'n',
    '<C-w-h>',
    '<cmd>wincmd h<CR>',
    vim.tbl_extend('force', opts, { desc = '[Modular] Move to left window' })
)

vim.keymap.set(
    'n',
    '<C-w-j>',
    '<cmd>wincmd j<CR>',
    vim.tbl_extend('force', opts, { desc = '[Modular] Move to bottom window' })
)

vim.keymap.set(
    'n',
    '<C-w-k>',
    '<cmd>wincmd k<CR>',
    vim.tbl_extend('force', opts, { desc = '[Modular] Move to top window' })
)

vim.keymap.set(
    'n',
    '<C-w-l>',
    '<cmd>wincmd l<CR>',
    vim.tbl_extend('force', opts, { desc = '[Modular] Move to right window' })
)

vim.keymap.set(
    'n',
    '<leader>wv',
    '<C-w>v',
    vim.tbl_extend('force', opts, { desc = 'Window: Split Vertical' })
)

vim.keymap.set(
    'n',
    '<leader>wh',
    '<C-w>s',
    vim.tbl_extend('force', opts, { desc = 'Window: Split Horizontal' })
)

vim.keymap.set(
    'n',
    '<leader>we',
    '<C-w>=',
    vim.tbl_extend('force', opts, { desc = 'Window: Set Equal Sizes' })
)

vim.keymap.set(
    'n',
    '<leader>wc',
    '<cmd>close<CR>',
    vim.tbl_extend('force', opts, { desc = 'Window: Close' })
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

-- [[ Buffer ]]
vim.keymap.set(
    'n',
    '<leader>bx',
    '<cmd>Bdelete!<CR>',
    vim.tbl_extend('force', opts, { desc = 'Buffer: Close' })
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
end, { desc = 'Buffer: Close All' })

vim.keymap.set(
    'n',
    '<leader>bX',
    '<cmd>BdeleteAll<CR>',
    vim.tbl_extend('force', opts, { desc = 'Buffer: Close All' })
)

vim.keymap.set(
    'n',
    '<leader>bn',
    '<cmd>new<CR>',
    vim.tbl_extend('force', opts, { desc = 'Buffer: New' })
)

-- [[ Misc ]]
vim.keymap.set(
    'n',
    '<C-q>',
    '<cmd>q<CR>',
    vim.tbl_extend('force', opts, { desc = 'Quit' })
)

vim.keymap.set(
    'n',
    'Q',
    '<nop>',
    vim.tbl_extend('force', opts, { desc = '[Modular] Disable Q command' })
)

vim.keymap.set(
    'n',
    '<C-c>',
    '<nop>',
    vim.tbl_extend(
        'force',
        opts,
        { desc = '[Modular] Disable Ctrl-C command' }
    )
)

vim.keymap.set(
    'n',
    '<leader>ne',
    ':!chmod +x %<CR>',
    vim.tbl_extend('force', opts, { desc = 'Make Executable' })
)
