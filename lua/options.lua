-- Line number settings
vim.opt.number = true
vim.opt.relativenumber = true

-- Text settings
vim.opt.wrap = false
vim.opt.textwidth = 79
vim.opt.breakindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.fileencoding = 'utf-8'
vim.opt.undofile = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Visual settings
vim.opt.linebreak = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'

-- Mouse settings
vim.opt.mouse = 'a'

-- Mode settings
vim.opt.showmode = true

-- Clipboard settings
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
end)

-- Performance settings
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300

-- Window settings
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Whitespace settings
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Live substitution preview
vim.opt.inccommand = 'split'

-- Indentation and tab settings
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Interaction settings
vim.opt.backspace = 'indent,eol,start'
vim.opt.pumheight = 10
vim.opt.completeopt = 'menuone,noselect'
vim.opt.shortmess:append 'c'
vim.opt.iskeyword:append '-'
vim.opt.formatoptions:remove { 'c', 'r', 'o' }

-- Backup settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.undofile = true

-- Runtime path settings
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'
