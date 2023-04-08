local status_ok, mkdnflow = pcall(require, "mkdnflow")
if not status_ok then
	return
end

mkdnflow.setup({
	modules = {
		bib = true,
		buffers = true,
		conceal = true,
		cursor = true,
		folds = false,
		links = true,
		lists = true,
		maps = true,
		paths = true,
		tables = true,
		yaml = false,
	},
})
