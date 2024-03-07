return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dB", "<cmd>lua require'dap'.clear_breakpoints()<cr>", desc = "Clear Breakpoints" },
    },
    opts = function ()
      require("dap.ext.vscode").load_launchjs(nil, { codelldb = {'c', 'cpp'} })
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-debug-adapter",
        "debugpy",
      },
    },
  },
}
