local M = {}
local fonts = {
  -- {
  --   family = "JetBrains Mono",
  --   weight = "Light",
  --   harfbuzz_features = { "calt=1", "ss01" },
  -- },
  -- { family = 'Terminus', weight = 'Bold' },
  -- { family = "Cascadia Code", weight = "Medium", harfbuzz_features = { "calt=1", "ss01" } },
  -- { family = "VictorMono Nerd Font Mono", weight = "Medium", harfbuzz_features = { "calt=1", "ss01" } },
  "Droid Sans Fallback",
  "Noto Color Emoji",
  -- "Noto Sans Javanese",
  -- "Noto Serif Tibetan",
  -- "Noto Sans Ol Chiki",
}

local macos_fonts = {
  { family = "FiraCode Nerd Font Mono", weight = "Medium", harfbuzz_features = { "calt=1", "ss01" } },
}

local linux_fonts = {
  { family = "Fira Code Nerd Font Mono", weight = "Medium", harfbuzz_features = { "calt=1", "ss01" } },
}

M.setup = function(config, wezterm)
  if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
    fonts = table.pack(table.unpack(macos_fonts), table.unpack(fonts))
  elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    fonts = table.pack(table.unpack(linux_fonts), table.unpack(fonts))
  end
  config.font = wezterm.font_with_fallback(fonts)
  config.freetype_load_flags = "NO_HINTING"
  config.freetype_load_target = "Light"
  config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
  config.font_size = 14.0
  config.line_height = 0.9
  config.cell_width = 0.95
  config.underline_thickness = 2.0
  config.underline_position = -1.1
end

return M
