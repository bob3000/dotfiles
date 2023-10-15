local M = {}
M.setup = function(wezterm, config)
  config.scrollback_lines = 10000
  if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
    config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
  elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    config.default_prog = { "/usr/bin/fish", "-l" }
  end
end

return M
