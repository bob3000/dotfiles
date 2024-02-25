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
vim.g.root_spec = { "lsp", root_marker, "cwd" }
vim.g.autoformat = false

vim.opt.spell = true
vim.opt.guicursor = "a:blinkon100,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.colorcolumn = "79,120"

local socket = os.getenv("HOME") .. "/.cache/nvim/nvim-" .. os.time() .. ".pipe"
vim.fn.serverstart(socket)
