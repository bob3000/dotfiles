local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local handlers_ok, handlers = pcall(require, "user.lsp.handlers")
if not handlers_ok then
  vim.notify("could not attach key maps", vim.log.levels.ERROR)
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
  on_attach = handlers.attach_keymaps,
	debug = false,
	sources = {
		code_actions.cspell,
		code_actions.gitsigns,
		diagnostics.codespell,
		diagnostics.cspell,
		diagnostics.flake8,
		diagnostics.markdownlint,
		formatting.prettier.with({
			extra_filetypes = { "toml" },
		}),
		formatting.black.with({ extra_args = { "--fast", "--line-length", "79" } }),
		formatting.codespell.with({
			extra_args = { "--skip", "*.latex,*.md" },
		}),
		formatting.isort,
		formatting.stylua,
		formatting.npm_groovy_lint,
		formatting.shfmt,
	},
})
