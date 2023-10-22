local M = {}
M.setup = function(config)
	config.adjust_window_size_when_changing_font_size = false
	config.window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	}
end

return M
