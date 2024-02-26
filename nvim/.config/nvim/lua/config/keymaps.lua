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
  ["<M-h>"] = { "<cmd>DapStepOut<cr>", "Step Out" },
  ["<M-t>"] = { "<cmd>DapTerminate<cr>", "Terminate" },
  ["<M-j>"] = { "<cmd>DapStepOver<cr>", "Step Over" },
  ["<M-l>"] = { "<cmd>DapStepInto<cr>", "Step Into" },
  ["<M-r>"] = { "<cmd>DapToggleRepl<cr>", "Toggle Repl" },
  ["<M-b>"] = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
  ["<M-u>"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle DAP UI" },
}

require("which-key").register(mappings_no_prefix, opts_no_prefix)

vim.keymap.set({ "x", "n", "s" }, "<C-x>", function()
  require("mini.bufremove").delete(0, true)
end, { desc = "Close buffer" })

vim.keymap.set({ "x", "n", "s" }, "<C-c>", function()
  pcall(vim.api.nvim_win_close, 0, false)
end, { desc = "Close window" })

-- move buffers
map("n", "<S-A-l>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })
map("n", "<S-A-h>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
map("n", "<leader>fP", "<cmd>e " .. vim.fn.expand("$HOME") .. "/.local/share/nvim/project_nvim/project_history<CR>", { desc = "Edit project history" })
map("n", "<leader>cw", "<cmd>%s/ \\+$//<CR>", { desc = "Remove trailing whitespace" })
map("v", "<leader>co", ":'<,'>sort<CR>", { desc = "Order lines" })

-- compiler
-- Open compiler
vim.api.nvim_set_keymap('n', '<M-e>', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })

-- Redo last selected option
vim.api.nvim_set_keymap('n', '<S-M-e>',
     "<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
  .. "<cmd>CompilerRedo<cr>",
 { noremap = true, silent = true })

-- Toggle compiler results
vim.api.nvim_set_keymap('n', '<M-o>', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })
