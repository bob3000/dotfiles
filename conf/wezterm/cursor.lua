local M = {}
M.setup = function(config)
  config.cursor_blink_rate = 0
  config.cursor_thickness = 1.0
  config.cursor_blink_ease_in = "Constant"
  config.cursor_blink_ease_out = "Constant"
end

return M
