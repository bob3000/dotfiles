vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig", version = vim.version.range("*") },
  { src = "https://github.com/mason-org/mason.nvim", version = vim.version.range("*") },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim", version = vim.version.range("*") },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/b0o/schemastore.nvim" },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "bash-debug-adapter",
    "biome",
    "cmakelang",
    "cmakelint",
    "codelldb",
    "debugpy",
    "delve",
    "firefox-debug-adapter",
    "gofumpt",
    "goimports",
    "hadolint",
    "js-debug-adapter",
    "markdownlint",
    "markdown-toc",
    "ruff",
    "prettier",
    "shellcheck",
    "shfmt",
    "stylua",
    "taplo",
  },
})
