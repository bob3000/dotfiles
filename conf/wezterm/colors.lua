local M = {}
M.scheme = {}

M.get_appearance = function(wezterm)
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

M.scheme_for_appearance = function(appearance)
    if appearance:find "Dark" then
      return "Everforest Dark (Gogh)"
    else
      return "Papercolor Light (Gogh)"
    end
  end

M.setup = function(config, wezterm)
  local scheme_name = M.scheme_for_appearance(M.get_appearance(wezterm))
  config.color_scheme = scheme_name
  M.scheme = wezterm.color.get_builtin_schemes()[scheme_name]

  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.6,
  }
end

return M
