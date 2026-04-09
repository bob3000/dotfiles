return {
  vim.pack.add({
    { src = "https://github.com/nvim-neotest/neotest", version = vim.version.range("*") },
    { src = "https://github.com/nvim-neotest/nvim-nio", version = vim.version.range("*") },
    { src = "https://github.com/nvim-lua/plenary.nvim", version = vim.version.range("*") },
    { src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
    { src = "https://github.com/nvim-neotest/neotest-python" },
    { src = "https://github.com/nvim-neotest/neotest-jest" },
    { src = "https://github.com/rouge8/neotest-rust" },
    { src = "https://github.com/fredrikaverpil/neotest-golang" },
    { src = "https://github.com/andythigpen/nvim-coverage", name = "coverage" },
  }),
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local name = ev.data.spec.name
      if name == "neotest-golang" then
        vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
      end
    end,
  }),
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "bash",
      "c",
      "cpp",
      "javascript",
      "javascriptreact",
      "go",
      "rust",
      "python",
      "typescript",
      "typescriptreact",
    },
    callback = function()
      local neotest_golang_opts = {
        runner = "gotestsum", -- Optional, but recommended
        -- runner = 'go',
      }
      require("neotest").setup({
        consumers = {
          overseer = require("neotest.consumers.overseer"),
        },
        -- log_level = 3,
        adapters = {
          require("neotest-golang")(neotest_golang_opts),
          require("neotest-python"),
          require("neotest-rust"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
      })

      vim.keymap.set("n", "<leader>tt", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, { desc = "Run File (Neotest)" })

      vim.keymap.set("n", "<leader>tT", function()
        require("neotest").run.run(vim.uv.cwd())
      end, { desc = "Run All Test Files (Neotest)" })

      vim.keymap.set("n", "<leader>tr", function()
        require("neotest").run.run()
      end, { desc = "Run Nearest (Neotest)" })

      vim.keymap.set("n", "<leader>tl", function()
        require("neotest").run.run_last()
      end, { desc = "Run Last (Neotest)" })

      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").summary.toggle()
      end, { desc = "Toggle Summary (Neotest)" })

      vim.keymap.set("n", "<leader>to", function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end, { desc = "Show Output (Neotest)" })

      vim.keymap.set("n", "<leader>tO", function()
        require("neotest").output_panel.toggle()
      end, { desc = "Toggle Output Panel (Neotest)" })

      vim.keymap.set("n", "<leader>tS", function()
        require("neotest").run.stop()
      end, { desc = "Stop (Neotest)" })

      vim.keymap.set("n", "<leader>tw", function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end, { desc = "Toggle Watch (Neotest)" })
    end,

    require("coverage").setup({
      auto_reload = true,
    }),

    vim.keymap.set(
      "n",
      "<leader>tc",
      (function() -- the included toggle command doesn't load before showing
        local cov_enabled = false
        return function()
          local cov = require("coverage")
          if not cov_enabled then
            cov.load(true)
          else
            cov.clear()
          end
          cov_enabled = not cov_enabled
        end
      end)(),
      { desc = "Coverage Toggle" }
    ),

    vim.keymap.set("n", "<leader>tC", function()
      local cov = require("coverage")
      cov.summary()
    end, { desc = "Coverage Summary" }),
  }),
}
