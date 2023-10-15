local M = {}
M.scheme = {}
M.setup = function(config, wezterm)
  config.color_scheme = "Gruvbox Dark (Gogh)"
  M.scheme = wezterm.color.get_builtin_schemes()["Gruvbox Dark (Gogh)"]

  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
  }
end

return M
