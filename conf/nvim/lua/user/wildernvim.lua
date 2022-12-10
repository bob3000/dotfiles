local ok, wilder = pcall(require, "wilder")
if not ok then
	return
end

wilder.setup({
	modes = { ":", "/", "?" },
	next_key = "<C-j>",
	previous_key = "<C-k>",
	accept_key = "<CR>",
	reject_key = "<ESC>",
})

wilder.set_option(
	"renderer",
	wilder.wildmenu_renderer({
		highlighter = wilder.basic_highlighter(),
	})
)
