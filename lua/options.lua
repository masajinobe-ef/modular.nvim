-- [[ Setting options ]]

-- Line number settings
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Mouse settings
vim.opt.mouse = 'a' -- Enable mouse mode

-- Mode settings
vim.opt.showmode = false -- Don't show the mode in the status line

-- Clipboard settings
vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
end)

-- Text settings
vim.opt.textwidth = 79 -- Text width
vim.opt.breakindent = true -- Enable break indent (default: false)
vim.opt.hlsearch = true -- Highlight search (default: true)
vim.opt.fileencoding = 'utf-8' -- File encoding (default: 'utf-8')
vim.opt.undofile = true -- Save undo history (default: false)

-- Search settings
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Case-sensitive if uppercase letters are used

-- Visual settings
vim.opt.linebreak = true -- Don't split words (default: false)
vim.opt.scrolloff = 10 -- Lines above/below cursor (default: 0)
vim.opt.sidescrolloff = 8 -- Columns beside cursor (default: 0)
vim.opt.cursorline = true -- Highlight current line (default: false)
vim.opt.termguicolors = true -- Enable highlight groups (default: false)
vim.opt.numberwidth = 4 -- Number column width (default: 4)
vim.opt.signcolumn = 'yes' -- Always show signcolumn (default: 'auto')

-- Performance settings
vim.opt.updatetime = 250 -- Update time (default: 4000)
vim.opt.timeoutlen = 300 -- Mapped sequence timeout (default: 1000)

-- Window settings
vim.opt.splitbelow = true -- Horizontal splits below (default: false)
vim.opt.splitright = true -- Vertical splits right (default: false)

-- Whitespace settings
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- Define whitespace characters

-- Live substitution preview
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!

-- Indentation and tab settings
vim.opt.autoindent = true -- Copy indent (default: true)
vim.opt.shiftwidth = 4 -- Spaces for indentation (default: 8)
vim.opt.tabstop = 4 -- Spaces for tab (default: 8)
vim.opt.softtabstop = 4 -- Spaces for editing tabs (default: 0)
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smarter indenting (default: false)

-- Interaction settings
vim.opt.backspace = 'indent,eol,start' -- Allow backspace (default: 'indent,eol,start')
vim.opt.pumheight = 10 -- Popup menu height (default: 0)
vim.opt.completeopt = 'menuone,noselect' -- Better completion (default: 'menu,preview')
vim.opt.shortmess:append 'c' -- Suppress completion messages (default: does not include 'c')
vim.opt.iskeyword:append '-' -- Hyphenated words (default: does not include '-')
vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- No auto comment leader (default: 'croql')

-- Backup settings
vim.opt.swapfile = false -- Create swapfile (default: true)
vim.opt.backup = false -- Create backup file (default: false)
vim.opt.writebackup = false -- Prevent editing if file is modified (default: true)

-- Runtime path settings
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Separate Vim plugins (default: includes this path)
