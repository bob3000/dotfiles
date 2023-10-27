-- language server configurations
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
  "ansiblels",
  "bashls",
  -- "clangd",
  -- "cmake",
  -- "cssls",
  -- "denols",
  "dockerls",
  -- "gopls",
  "html",
  "jsonls",
  "lua_ls",
  "pyright",
  -- "sqlls",
  -- "omnisharp",
  -- "solargraph",
  -- "tailwindcss",
  "terraformls",
  -- "texlab",
  "tsserver",
  "yamlls",
  -- "zls",
}

local linter_formatter = {
  "bash-debug-adapter",
  "bash-language-server",
  "black",
  "cspell",
  "flake8",
  "isort",
  "jq",
  "markdownlint",
  "markdown_toc",
  "prettier",
  "shfmt",
  "stylua",
}

local debugger = {
  "codelldb",
  "python",
}

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup {
  ensure_installed = servers,
  automatic_installation = true,
}

require("mason-null-ls").setup {
  ensure_installed = linter_formatter,
  automatic_installation = true,
}

require("mason-nvim-dap").setup {
  ensure_installed = debugger,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  lspconfig[server].setup(opts)
end
