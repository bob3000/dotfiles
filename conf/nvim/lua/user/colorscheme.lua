local M = {}
M.colorschemes = {
  "edge",
  "everforest",
  "gruvbox-material",
  "sonokai",
  "kanagawa",
  "tokyonight",
}

M.set_random_colorscheme = function()
  local timestamp = os.time(os.date "!*t")
  local selected_scheme = math.fmod(timestamp, #M.colorschemes) + 1
  local colorscheme = M.colorschemes[selected_scheme]

  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not status_ok then
    return false
  end
  return true
end

vim.cmd("colorscheme tokyonight")
return M
