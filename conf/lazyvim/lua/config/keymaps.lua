-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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

vim.keymap.set({ "x", "n", "s" }, "<C-x>", function() require("mini.bufremove").delete(0, true) end, { desc = "Close buffer" })
