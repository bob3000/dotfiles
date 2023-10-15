local M = {}
M.setup = function(config)
  config.unix_domains = {
    {
      name = 'unix',
    },
  }
  config.default_gui_startup_args = { 'connect', 'unix' }
end

return M
