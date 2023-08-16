local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_ok then
  vim.notify("could not attach key maps", vim.log.levels.ERROR)
end

local cspell_ok, cspell = pcall(require, "cspell")
if not cspell_ok then
  vim.notify("could not load cspell null-ls module", vim.log.levels.ERROR)
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  on_attach = handlers.attach_keymaps,
  debug = false,
  sources = {
    cspell.code_actions,
    code_actions.gitsigns,
    diagnostics.codespell.with {
      diagnostic_config = {
        underline = true,
        signs = false,
        -- NOT WORKING: won't expand tilde
        -- extra_args = { "--config", "~/.config/codespell/codespell.ini" },
      },
    },
    cspell.diagnostics.with {
      diagnostic_config = {
        underline = true,
        signs = false,
      },
    },
    -- diagnostics.npm_groovy_lint,
    diagnostics.fish,
    diagnostics.flake8,
    diagnostics.markdownlint,
    -- diagnostics.mypy,
    formatting.prettier.with {
      extra_filetypes = { "toml" },
    },
    formatting.black.with { extra_args = { "--fast", "--line-length", "79" } },
    -- formatting.nginx_beautifier,
    formatting.isort,
    formatting.fish_indent,
    formatting.markdownlint,
    formatting.markdown_toc,
    formatting.stylua,
    formatting.npm_groovy_lint,
    formatting.shfmt,
    formatting.uncrustify,
  },
}
