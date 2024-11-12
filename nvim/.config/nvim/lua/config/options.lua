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
  "index.md",
  "lua",
  "Makefile",
  "meson.build",
  "package.json",
  "pyproject.toml",
}

-- is either 'Linux' or 'Darwin'
os_name = vim.loop.os_uname().sysname

vim.filetype.add({ extension = { ipynb = "markdown" } })

vim.g.root_spec = { root_marker, "cwd" }
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
vim.opt.showbreak = "↪"
vim.opt.listchars = { -- define which invisible characters to show
  tab = "→┈",
  trail = "·",
  extends = "…",
  precedes = "…",
  nbsp = "‿",
  conceal = "￮",
}
vim.opt.list = true -- show some invisible characters

vim.g.enable_autocomplete = true
if vim.g.neovide then
  vim.g.neovide_input_macos_option_key_is_meta = "both"
end

local socket = os.getenv("HOME") .. "/.cache/nvim/nvim-" .. os.time() .. ".pipe"
vim.fn.serverstart(socket)
