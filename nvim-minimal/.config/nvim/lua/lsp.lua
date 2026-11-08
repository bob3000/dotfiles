vim.opt.pumheight = 7
vim.opt.pummaxwidth = 40
vim.opt.pumborder = "rounded"
vim.opt.complete = ".,o"
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" } -- completion menu options
vim.opt.autocomplete = true

vim.lsp.enable({ "lua_ls", "clangd" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", {}),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
