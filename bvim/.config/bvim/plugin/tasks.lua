vim.pack.add({
  { src = "https://github.com/stevearc/overseer.nvim", version = vim.version.range("*") },
})

require("overseer").setup({
  dap = false,
  task_list = {
    direction = "right",
    bindings = {
      ["<C-h>"] = false,
      ["<C-j>"] = false,
      ["<C-k>"] = false,
      ["<C-l>"] = false,
    },
  },
  form = {
    win_opts = {
      winblend = 0,
    },
  },
  confirm = {
    win_opts = {
      winblend = 0,
    },
  },
  task_win = {
    win_opts = {
      winblend = 0,
    },
  },
})

vim.keymap.set("n", "<leader>ow", "<cmd>OverseerToggle<cr>", { desc = "Task list" })
vim.keymap.set("n", "<leader>oo", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>oq", "<cmd>OverseerQuickAction<cr>", { desc = "Action recent task" })
vim.keymap.set("n", "<leader>oi", "<cmd>OverseerInfo<cr>", { desc = "Overseer Info" })
vim.keymap.set("n", "<leader>ob", "<cmd>OverseerBuild<cr>", { desc = "Task builder" })
vim.keymap.set("n", "<leader>ot", "<cmd>OverseerTaskAction<cr>", { desc = "Task action" })
vim.keymap.set("n", "<leader>oc", "<cmd>OverseerClearCache<cr>", { desc = "Clear cache" })
vim.keymap.set("n", "<leader>ol", "<cmd>OverseerRestartLast<cr>", { desc = "Overseer Last Task" })
