local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- options
config.scrollback_lines = 10000
if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.default_prog = { "/usr/bin/fish", "-l" }
end
config.hide_tab_bar_if_only_one_tab = true

-- colors
config.color_scheme = "Gruvbox Dark (Gogh)"
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.8,
}

-- cursor
config.cursor_blink_rate = 1800
config.cursor_thickness = 1.0

-- font
config.font = wezterm.font_with_fallback({
	{
		family = "JetBrains Mono",
		weight = "Medium",
		harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
	},
	{ family = "Fira Code Nerd Font Mono", weight = "Medium" },
	{ family = "DejaVu Sans Mono", weight = "Medium" },
	"Noto Serif Tibetan",
	"Noto Sans Javanese",
	"Droid Sans Fallback",
	"Noto Sans Ol Chiki",
	"Noto Color Emoji",
})
config.font_size = 13.0
config.line_height = 0.9
config.cell_width = 0.95
config.underline_thickness = 2.0
config.underline_position = -2.1

-- window
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}

-- keys
config.leader = { key="b", mods="CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- tmux like key map
  { key = "b", mods = "LEADER|CTRL",  action=wezterm.action{SendString="\x01"}},
  { key = "%", mods = "LEADER|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "\"",mods = "LEADER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "s", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "v", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "o", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
  { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
  { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
  { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
  { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
  { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
  { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
  { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
  { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
  { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
  { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
  { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
  { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
  { key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
  { key = "&", mods = "LEADER|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
  { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},

}

-- status bar
wezterm.on("update-right-status", function(window, pane)
  -- Each element holds the text for a cell in a "powerline" style << fade
  local cells = {};

  -- Figure out the cwd and host of the current pane.
  -- This will pick up the hostname for the remote host if your
  -- shell is using OSC 7 on the remote host.
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    cwd_uri = cwd_uri:sub(8);
    local slash = cwd_uri:find("/")
    local cwd = ""
    local hostname = ""
    if slash then
      hostname = cwd_uri:sub(1, slash-1)
      -- Remove the domain name portion of the hostname
      local dot = hostname:find("[.]")
      if dot then
        hostname = hostname:sub(1, dot-1)
      end
      -- and extract the cwd from the uri
      cwd = cwd_uri:sub(slash)

      table.insert(cells, cwd);
      table.insert(cells, hostname);
    end
  end

  -- I like my date/time in this style: "Wed Mar 3 08:14"
  local date = wezterm.strftime("%a %b %-d %H:%M");
  table.insert(cells, date);

  -- An entry for each battery (typically 0 or 1 battery)
  for _, b in ipairs(wezterm.battery_info()) do
    table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
  end

  -- The powerline < symbol
  local LEFT_ARROW = utf8.char(0xe0b3);
  -- The filled in variant of the < symbol
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  -- Color palette for the backgrounds of each cell
  local colors = {
    "#343f44",
    "#3d484d",
    "#475258",
    "#4f585e",
    "#56635f",
  };

  -- Foreground color for the text across the fade
  local text_fg = "#c0c0c0";

  -- The elements to be formatted
  local elements = {};
  -- How many cells have been formatted
  local num_cells = 0;

  -- Translate a cell into elements
  function push(text, is_last)
    local cell_no = num_cells + 1
    table.insert(elements, {Foreground={Color=text_fg}})
    table.insert(elements, {Background={Color=colors[cell_no]}})
    table.insert(elements, {Text=" "..text.." "})
    if not is_last then
      table.insert(elements, {Foreground={Color=colors[cell_no+1]}})
      table.insert(elements, {Text=SOLID_LEFT_ARROW})
    end
    num_cells = num_cells + 1
  end

  table.insert(elements, {Foreground={Color=colors[1]}})
  table.insert(elements, {Text=SOLID_LEFT_ARROW})
  while #cells > 0 do
    local cell = table.remove(cells, 1)
    push(cell, #cells == 0)
  end

  window:set_right_status(wezterm.format(elements));
end);

return config
