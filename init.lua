-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw (file manager)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Nerd Font
vim.g.have_nerd_font = true

-- Modular
require 'options'
require 'keymaps'
require 'autocmds'
require 'lazy-bootstrap'
require 'lazy-plugins'
