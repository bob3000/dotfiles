-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- This file is automatically loaded by lazyvim.config.init
local Util = require("lazyvim.util")

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = Util.safe_keymap_set

local opts_no_prefix = {
  prefix = "",
  mode = "n", -- NORMAL mode
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end, {})

local mappings_no_prefix = {
  { "<M-b>", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle Breakpoint", nowait = true, remap = false },
  { "<M-c>", "<cmd>DapContinue<cr>", desc = "Continue", nowait = true, remap = false },
  { "<M-e>", "<cmd>OverseerRun<cr>", desc = "Overseer Run", nowait = true, remap = false },
  { "<M-i>", "<cmd>DapStepInto<cr>", desc = "Step Into", nowait = true, remap = false },
  { "<M-o>", "<cmd>DapStepOver<cr>", desc = "Step Over", nowait = true, remap = false },
  { "<M-r>", "<cmd>DapToggleRepl<cr>", desc = "Toggle Repl", nowait = true, remap = false },
  { "<M-t>", "<cmd>DapTerminate<cr>", desc = "Terminate", nowait = true, remap = false },
  { "<M-u>", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle DAP UI", nowait = true, remap = false },
  { "<S-M-e>", "<cmd>OverseerRestartLast<cr>", desc = "Overseer Last Task", nowait = true, remap = false },
  { "<S-M-m>", "<cmd>lua require'osv'.launch({port = 8086})<cr>", desc = "Debug Neovim", nowait = true, remap = false },
  { "<S-M-o>", "<cmd>DapStepOut<cr>", desc = "Step Out", nowait = true, remap = false },
}
require("which-key").add(mappings_no_prefix)

vim.keymap.set({ "x", "n", "s" }, "<C-c>", function() Snacks.bufdelete() end, { desc = "Close buffer" })
vim.keymap.set({ "x", "n", "s" }, "<C-q>", function()
  pcall(vim.api.nvim_win_close, 0, false)
end, { desc = "Close window" })

-- move buffers
map("n", "<S-A-l>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })
map("n", "<S-A-h>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
map(
  "n",
  "<leader>fP",
  "<cmd>e " .. vim.fn.stdpath("data") .. "/project_nvim/project_history<CR>",
  { desc = "Edit project history" }
)
map("n", "<leader>cw", "<cmd>%s/ \\+$//<CR>", { desc = "Remove trailing whitespace" })
map("v", "<leader>co", ":'<,'>sort<CR>", { desc = "Order lines" })
map("n", "dm", ":execute 'delmarks '.nr2char(getchar())<CR>", { desc = "Delete mark" })
map("n", "dm*", ":execute 'delmarks!'<CR>", { desc = "Delete all marks" })

if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.1)
  end)
end
