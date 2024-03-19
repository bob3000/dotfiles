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

local mappings_no_prefix = {
  ["<M-c>"] = { "<cmd>DapContinue<cr>", "Continue" },
  ["<S-M-o>"] = { "<cmd>DapStepOut<cr>", "Step Out" },
  ["<M-t>"] = { "<cmd>DapTerminate<cr>", "Terminate" },
  ["<M-o>"] = { "<cmd>DapStepOver<cr>", "Step Over" },
  ["<M-i>"] = { "<cmd>DapStepInto<cr>", "Step Into" },
  ["<M-r>"] = { "<cmd>DapToggleRepl<cr>", "Toggle Repl" },
  ["<M-b>"] = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
  ["<M-u>"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle DAP UI" },
  ["<S-M-m>"] = { "<cmd>lua require'osv'.launch({port = 8086})<cr>", "Debug Neovim" },
  ["<M-e>"] = { "<cmd>OverseerRun<cr>", "Overseer Run" },
  ["<S-M-e>"] = { "<cmd>OverseerRestartLast<cr>", "Overseer Last Task" },
}

require("which-key").register(mappings_no_prefix, opts_no_prefix)

vim.keymap.set({ "x", "n", "s" }, "<C-c>", function()
  require("mini.bufremove").delete(0, true)
end, { desc = "Close buffer" })

vim.keymap.set({ "x", "n", "s" }, "<C-q>", function()
  pcall(vim.api.nvim_win_close, 0, false)
end, { desc = "Close window" })

-- move buffers
map("n", "<S-A-l>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })
map("n", "<S-A-h>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
map(
  "n",
  "<leader>fP",
  "<cmd>e " .. vim.fn.expand("$HOME") .. "/.local/share/nvim/project_nvim/project_history<CR>",
  { desc = "Edit project history" }
)
map("n", "<leader>cw", "<cmd>%s/ \\+$//<CR>", { desc = "Remove trailing whitespace" })
map("v", "<leader>co", ":'<,'>sort<CR>", { desc = "Order lines" })
map("n", "dm", ":execute 'delmarks '.nr2char(getchar())<CR>", { desc = "Delete mark" })
map("n", "dm*", ":execute 'delmarks!'<CR>", { desc = "Delete all marks" })
