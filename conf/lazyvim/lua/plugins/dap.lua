return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dB", "<cmd>lua require'dap'.clear_breakpoints()<cr>", desc = "Clear Breakpoints" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-debug-adapter",
      },
    },
  },
}
