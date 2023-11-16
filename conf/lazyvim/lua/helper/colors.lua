local M = {}

M.get_colors = function()
  local config = require("everforest").config
  local colors = require("everforest.colours").generate_palette(config, "dark")
  return colors
end

return M
