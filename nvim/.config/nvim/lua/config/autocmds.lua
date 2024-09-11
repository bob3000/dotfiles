-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.cursorline = false
    vim.opt.cursorcolumn = false
  end,
})

-- switch to relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = true
  end,
})

-- treat jinja2 templates as html
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.j2" },
  command = "set ft=html",
})
