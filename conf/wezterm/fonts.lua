local M = {}
M.setup = function(config, wezterm)
  config.font = wezterm.font_with_fallback {
    {
      family = "JetBrains Mono",
      weight = "Medium",
      harfbuzz_features = { "calt=1", "ss01" },
    },
    -- { family = 'Terminus', weight = 'Bold' },
    -- { family = "Fira Code Nerd Font Mono", weight = "Medium" },
    { family = "DejaVu Sans Mono", weight = "Medium" },
    "Droid Sans Fallback",
    "Noto Color Emoji",
    "Noto Sans Javanese",
    "Noto Serif Tibetan",
    "Noto Sans Ol Chiki",
  }
  config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  config.font_size = 15.0
  config.line_height = 0.9
  config.cell_width = 0.95
  config.underline_thickness = 2.0
  -- config.underline_position = -1.1
end

return M
