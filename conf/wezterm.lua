local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Everforest Dark'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrains Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  },
  { family = 'Terminus', weight = 'Bold' },
  'Noto Color Emoji',
}
config.font_size = 15.0

return config
