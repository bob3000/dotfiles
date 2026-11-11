-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('options')
require('plugins')
require('treesitter')
require('autocmd')
require('lsp')
require('keymaps')

vim.cmd.colorscheme('catppuccin')
