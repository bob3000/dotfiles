local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- domains
config.unix_domains = {
  {
    name = 'unix',
  },
}

-- options
config.scrollback_lines = 10000
if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.default_prog = { "/usr/bin/fish", "-l" }
end
config.default_gui_startup_args = { 'connect', 'unix' }

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
  { key = ':', mods = 'LEADER|SHIFT', action=act.ActivateCommandPalette},
  { key = "b", mods = "LEADER|CTRL",  action=act{SendString="\x01"}},
  { key = "[", mods = "LEADER",       action=act.ActivateCopyMode},
  { key = "]", mods = "LEADER",       action=act.PasteFrom "Clipboard"},
  { key = "{", mods = "LEADER|SHIFT", action=act.RotatePanes "Clockwise"},
  { key = "}", mods = "LEADER|SHIFT", action=act.RotatePanes "CounterClockwise"},
  { key = "t", mods = "LEADER|CTRL",  action=act.QuickSelect},
  { key = "%", mods = "LEADER|SHIFT", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "\"",mods = "LEADER|SHIFT", action=act{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "s", mods = "LEADER",       action=act{SplitVertical={domain="CurrentPaneDomain"}}},
  { key = "v", mods = "LEADER",       action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
  { key = "o", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action=act{SpawnTab="CurrentPaneDomain"}},
  { key = "h", mods = "LEADER",       action=act{ActivatePaneDirection="Left"}},
  { key = "j", mods = "LEADER",       action=act{ActivatePaneDirection="Down"}},
  { key = "k", mods = "LEADER",       action=act{ActivatePaneDirection="Up"}},
  { key = "l", mods = "LEADER",       action=act{ActivatePaneDirection="Right"}},
  { key = "H", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Left", 5}}},
  { key = "J", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Down", 5}}},
  { key = "K", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Up", 5}}},
  { key = "L", mods = "LEADER|SHIFT", action=act{AdjustPaneSize={"Right", 5}}},
  { key = "1", mods = "LEADER",       action=act{ActivateTab=0}},
  { key = "2", mods = "LEADER",       action=act{ActivateTab=1}},
  { key = "3", mods = "LEADER",       action=act{ActivateTab=2}},
  { key = "4", mods = "LEADER",       action=act{ActivateTab=3}},
  { key = "5", mods = "LEADER",       action=act{ActivateTab=4}},
  { key = "6", mods = "LEADER",       action=act{ActivateTab=5}},
  { key = "7", mods = "LEADER",       action=act{ActivateTab=6}},
  { key = "8", mods = "LEADER",       action=act{ActivateTab=7}},
  { key = "9", mods = "LEADER",       action=act{ActivateTab=8}},
  { key = "&", mods = "LEADER|SHIFT", action=act{CloseCurrentTab={confirm=true}}},
  { key = "x", mods = "LEADER",       action=act{CloseCurrentPane={confirm=true}}},
  { key = "q", mods = "LEADER|CTRL",  action=act.PaneSelect},
  { key = 's', mods = 'LEADER',       action=act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }, },
  {
    key = 'S',
    mods = 'LEADER|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Green' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  { key = 'u', mods = 'LEADER|CTRL',
    action = wezterm.action.CharSelect {
      copy_on_select = true,
      copy_to = 'ClipboardAndPrimarySelection',
    },
  },
}

-- copy mode keys
local copy_mode = nil
copy_mode = wezterm.gui.default_key_tables().copy_mode
copy_override = {
  { key = '?', mods = 'LEADER|SHIFT', action=act.Search{CaseSensitiveString = ""}}
}
for _, key in ipairs(copy_override) do
  table.insert(copy_mode, key)
end

config.key_tables = {
    copy_mode = copy_mode,
}

-- status bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)

    local colors = {
      "#343f44",
      "#3d484d",
      "#475258",
      "#4f585e",
      "#56635f",
    };
    local text_fg = "#c0c0c0";
    local edge_background = colors[1]
    local background = colors[5]
    local foreground = text_fg

    if tab.is_active then
      background = colors[3]
      foreground = text_fg
    elseif hover then
      background = colors[4]
      foreground = text_fg
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

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
  table.insert(cells, window:active_workspace())

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
