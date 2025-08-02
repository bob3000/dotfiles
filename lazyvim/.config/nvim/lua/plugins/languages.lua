return {
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   config = function()
  --     if vim.fn.has("win32") == 1 then
  --       require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
  --     else
  --       require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"), {
  --         pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
  --       })
  --     end
  --   end,
  -- },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-jest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {
          -- vitestCommand = "npm test --",
          vitestCommand = "node_modules/vitest/vitest.mjs run --inspect=9229 --no-file-parallelism --test-timeout=0",
          -- vitestConfigFile = "vitest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
        ["neotest-jest"] = {
          jestCommand = "npm test --",
          -- jestCommand = "pnpm test --",
          -- jestCommand = "yarn test",
          -- jestConfigFile = 'custom.jest.config.ts',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "fish",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gpg",
        "groovy",
        "hcl",
        "helm",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json",
        "json5",
        "jq",
        "kotlin",
        "latex",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "pem",
        "perl",
        "php",
        "printf",
        "pug",
        "python",
        "regex",
        "ruby",
        "rust",
        "scss",
        "ssh_config",
        "sql",
        "templ",
        "tmux",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml",
        "zig",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
}
