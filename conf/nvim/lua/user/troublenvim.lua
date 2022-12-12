local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

trouble.setup({
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = true, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
})

local status_ok, todo = pcall(require, "todo-comments")
if not status_ok then
	return
end

todo.setup({})
