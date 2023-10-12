local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_prog = { '/usr/bin/fish', '-l' }
config.color_scheme = 'Everforest Dark (Gogh)'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback {
  {
    family = 'JetBrains Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
  },
  { family = 'Fira Code Nerd Font Mono', weight = 'Medium' },
  { family = 'DejaVu Sans Mono', weight = 'Medium' },
  'Noto Serif Tibetan',
  'Noto Sans Javanese',
  'Droid Sans Fallback',
  'Noto Sans Ol Chiki',
  'Noto Color Emoji',
}
config.font_size = 13.0

return config
