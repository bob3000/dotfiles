return {
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
    dependencies = { "stevearc/overseer.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    version = "*",
    lazy = true,
    config = function()
      require("overseer").setup()
      require("dap.ext.vscode").json_decode = require("overseer.json").decode

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})

      local overseer_keys = {
        ["<leader>o"] = {
          name = "+overseer",
          a = { "<cmd>OverseerTaskAction<cr>", "Overseer Action" },
          b = { "<cmd>OverseerBuild<cr>", "Overseer Build" },
          l = { "<cmd>OverseerLoadBundle!<cr>", "Overseer Load Bundle" },
          i = { "<cmd>OverseerInfo<cr>", "Overseer Info" },
          o = { "<cmd>OverseerRestartLast<cr>", "Overseer Last Task" },
          q = { "<cmd>OverseerQuickAction<cr>", "Overseer Quick Action" },
          r = { "<cmd>OverseerRun<cr>", "Overseer Run" },
          s = { "<cmd>OverseerSaveBundle<cr>", "Overseer Save Bundle" },
          t = { "<cmd>OverseerToggle!<cr>", "Overseer Toggle" },
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
