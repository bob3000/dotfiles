local M = {}
M.setup = function(config, wezterm)
  local act = wezterm.action
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
  -- local copy_mode = nil
  -- copy_mode = wezterm.gui.default_key_tables().copy_mode
  -- local copy_override = {
  --   { key = '?', mods = 'LEADER|SHIFT', action=act.Search{CaseSensitiveString = ""}}
  -- }
  -- for _, key in ipairs(copy_override) do
  --   table.insert(copy_mode, key)
  -- end
  --
  -- config.key_tables = {
  --     copy_mode = copy_mode,
  -- }

end

return M
