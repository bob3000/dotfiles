local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- options
config.scrollback_lines = 10000
config.default_prog = { '/usr/bin/fish', '-l' }
config.hide_tab_bar_if_only_one_tab = true

-- colors
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
}

-- cursor
config.cursor_blink_rate = 1800
config.cursor_thickness = 1.0

-- font
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
config.line_height = 0.9
config.cell_width = 0.95
config.underline_thickness = 2.0
config.underline_position = -2.1

-- window
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

return config
