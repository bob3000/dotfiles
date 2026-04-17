local tools = require 'config.tools'

return {
  -- Automatically install LSPs and related tools to stdpath for Neovim
  -- Mason must be loaded before its dependents so we need to set it up here.
  -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
  {
    'mason-org/mason.nvim',
    dependencies = {
      { 'mason-org/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'b0o/schemastore.nvim' },
    },
    config = function ()
      require("mason").setup({})
      -- install tools
      local ensure_installed = tools.servers
      vim.list_extend(ensure_installed, tools.tools)
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (installs populated via mason-tool-installer)
        automatic_installation = false,
      }
    end
  },
}
