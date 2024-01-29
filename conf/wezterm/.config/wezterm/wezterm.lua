local wezterm = require "wezterm"
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local colors = require "colors"

require("options").setup(wezterm, config)
colors.setup(config, wezterm)
require("domains").setup(config, wezterm)
require("cursor").setup(config)
require("fonts").setup(config, wezterm)
require("window").setup(config)
require("keys").setup(config, wezterm)
require("statusbar").setup(config, wezterm, colors.scheme)
require("zenmode").setup(wezterm)
require("startup").setup(config, wezterm)

return config
