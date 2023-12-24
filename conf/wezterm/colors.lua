local M = {}
M.scheme = {}

local function ends_with(str, ending)
  return ending == "" or str:sub(-#ending) == ending
end

local function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

local function update_nvim_theme(mode)
  local sockets_dir = os.getenv("HOME") .. "/.cache/nvim"
  for _, socket in ipairs(scandir(sockets_dir)) do
    if ends_with(socket, ".pipe") then
      local socket_path = sockets_dir .. "/" .. socket
      os.execute("nvim --server " .. socket_path .. " --remote-send ':set background=" .. mode .. "<cr>'")
    end
  end
end

M.get_appearance = function(wezterm)
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

M.scheme_for_appearance = function(appearance)
    if appearance:find "Dark" then
      update_nvim_theme("dark")
      return "Everforest Dark (Gogh)"
    else
      update_nvim_theme("light")
      return "Everforest Light (Gogh)"
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
