local M = {}
M.scheme = {}
M.setup = function(config, wezterm)
  local scheme_name = "Gruvbox Dark (Gogh)"
  config.color_scheme = scheme_name
  M.scheme = wezterm.color.get_builtin_schemes()[scheme_name]

  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.6,
  }
end

return M
