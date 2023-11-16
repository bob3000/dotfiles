return {
  {
    "stevearc/overseer.nvim",
    version = "*",
    lazy = true,
    config = function()
      require("overseer").setup()
      require("dap.ext.vscode").json_decode = require("overseer.json").decode
      local overseer_keys = {
        ["<leader>o"] = {
          name = "+overseer",
          a = { "<cmd>OverseerTaskAction<cr>", "Overseer Action" },
          b = { "<cmd>OverseerBuild<cr>", "Overseer Build" },
          l = { "<cmd>OverseerLoadBundle!<cr>", "Overseer Load Bundle" },
          o = { "<cmd>OverseerToggle!<cr>", "Overseer Toggle" },
          i = { "<cmd>OverseerInfo<cr>", "Overseer Info" },
          q = { "<cmd>OverseerQuickAction<cr>", "Overseer Quick Action" },
          r = { "<cmd>OverseerRun<cr>", "Overseer Run" },
          s = { "<cmd>OverseerSaveBundle<cr>", "Overseer Save Bundle" },
        },
      }
      require("which-key").register({ mode = { "n" }, overseer_keys })
    end,
    opts = {},
  },
  {
    "nvim-neotest/neotest",
    opts = function(_, opts)
      opts.consumers = opts.consumers or {}
      opts.consumers.overseer = require("neotest.consumers.overseer")
    end,
  },
}
