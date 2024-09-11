return {
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup(LazyVim.get_pkg_path("debugpy", "/venv/bin/python"), {
          pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
        })
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dockerfile",
        "fish",
        "go",
        "gomod",
        "gosum",
        "groovy",
        "hcl",
        "helm",
        "html",
        "json",
        "json",
        "json5",
        "latex",
        "lua",
        "luadoc",
        "make",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "nix",
        "norg",
        "python",
        "regex",
        "ruby",
        "rust",
        "scss",
        "sql",
        "templ",
        "toml",
        "typescript",
        "vue",
        "xml",
        "yaml",
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
