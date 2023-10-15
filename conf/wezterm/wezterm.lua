local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

require("options").setup(wezterm, config)
require("colors").setup(config)
require("domains").setup(config)
require("cursor").setup(config)
require("fonts").setup(config, wezterm)
require("window").setup(config)
require("keys").setup(config, wezterm)
require("statusbar").setup(config, wezterm)

return config
