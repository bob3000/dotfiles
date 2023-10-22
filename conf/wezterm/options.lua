local M = {}
M.setup = function(wezterm, config)
	config.scrollback_lines = 10000

	-- config.window_background_gradient = {
	--   orientation = 'Vertical',
	--   colors = {
	--     '#2d353b',
	--     '#232a2e',
	--     '#543a38',
	--     '#343f44',
	--   },
	-- }

	if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
		config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
		config.set_environment_variables = {
			SHELL = "/opt/homebrew/bin/fish",
		}
	elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
		config.default_prog = { "/usr/bin/fish", "-l" }
		config.set_environment_variables = {
			SHELL = "/usr/bin/fish",
		}
	end
end

return M
