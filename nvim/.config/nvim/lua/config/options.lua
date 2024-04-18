-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local root_marker = {
  ".editorconfig",
  ".git",
  "build.zig",
  "Cargo.toml",
  "Gemfile",
  "go.mod",
  "index.norg",
  "lua",
  "Makefile",
  "meson.build",
  "package.json",
  "pyproject.toml",
}

-- is either 'Linux' or 'Darwin'
os_name = vim.loop.os_uname().sysname

vim.g.maplocalleader = ","

vim.filetype.add({ extension = { ipynb = "markdown" } })

vim.g.root_spec = { "lsp", root_marker, "cwd" }
vim.g.autoformat = false
-- vim.g.python3_host_prog = vim.fn.expand("$HOME") .. "/.pyenv/shims/python"
vim.g.lazyvim_python_lsp = "basedpyright"

vim.opt.spell = true
vim.opt.spelloptions = "camel" -- consider camel case in spell checking
vim.opt.spellcapcheck = "" -- don't check for capital letters after full stop
vim.opt.guicursor = "a:blinkon100,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.colorcolumn = "80,120"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.listchars = "tab:»·,extends:…,precedes:<,extends:>,trail:·" -- define which invisible characters to show
vim.opt.list = true -- show some invisible characters
vim.opt.fillchars = "eob: " -- show empty lines at the end of a buffer as ` ` {default `~`}

local socket = os.getenv("HOME") .. "/.cache/nvim/nvim-" .. os.time() .. ".pipe"
vim.fn.serverstart(socket)
