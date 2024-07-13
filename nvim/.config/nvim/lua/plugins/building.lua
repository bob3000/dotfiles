return {
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
        { "<leader>o", group = "overseer" },
        { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Overseer Action" },
        { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Overseer Build" },
        { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
        { "<leader>ol", "<cmd>OverseerLoadBundle!<cr>", desc = "Overseer Load Bundle" },
        { "<leader>oo", "<cmd>OverseerRestartLast<cr>", desc = "Overseer Last Task" },
        { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Overseer Quick Action" },
        { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Overseer Run" },
        { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "Overseer Save Bundle" },
        { "<leader>ot", "<cmd>OverseerToggle!<cr>", desc = "Overseer Toggle" },
      }
      require("which-key").add(overseer_keys)
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
