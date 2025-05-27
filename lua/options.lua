--[[ General Settings ]]
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.fileencoding = 'utf-8'
vim.opt.iskeyword:append '-'

--[[ Interface Settings ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '81'
vim.opt.showmode = false

--[[ Window Management ]]
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

--[[ Text Rendering ]]
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.textwidth = 80

--[[ Search Settings ]]
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

--[[ Whitespace Handling ]]
vim.opt.list = true
vim.opt.listchars = {
    tab = '  ',
    trail = '·',
    nbsp = '␣',
}

--[[ Indentation & Tabs ]]
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

--[[ Performance ]]
vim.opt.updatetime = 1
vim.opt.timeoutlen = 300

--[[ Advanced Features ]]
vim.opt.inccommand = 'split'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.pumheight = 10
vim.opt.formatoptions:remove { 'c', 'r', 'o', 'a', 't' }

--[[ Security/Backups ]]
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

--[[ System Integration ]]
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'
