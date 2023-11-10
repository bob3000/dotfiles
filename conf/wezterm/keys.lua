local M = {}
M.setup = function(config, wezterm)
  local act = wezterm.action
  config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 2000 }
  config.keys = {
    -- move fullscreen binding
    { key = "Enter", mods = "ALT", action = act.SendKey { key = "Enter", mods = "ALT" } },
    { key = "Enter", mods = "CTRL", action = 'ToggleFullScreen' },
    -- tmux like key map
    { key = ":", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },
    { key = "b", mods = "LEADER|CTRL", action = act.ActivateLastTab },
    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "]", mods = "LEADER", action = act.PasteFrom "Clipboard" },
    { key = "{", mods = "LEADER|SHIFT", action = act.RotatePanes "Clockwise" },
    { key = "}", mods = "LEADER|SHIFT", action = act.RotatePanes "CounterClockwise" },
    { key = "t", mods = "LEADER|CTRL", action = act.QuickSelect },
    { key = "%", mods = "LEADER|SHIFT", action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = '"', mods = "LEADER|SHIFT", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "s", mods = "LEADER", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "v", mods = "LEADER", action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    { key = "o", mods = "LEADER", action = "TogglePaneZoomState" },
    { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
    { key = "c", mods = "LEADER", action = act { SpawnTab = "CurrentPaneDomain" } },
    { key = "h", mods = "LEADER", action = act { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "LEADER", action = act { ActivatePaneDirection = "Down" } },
    { key = "k", mods = "LEADER", action = act { ActivatePaneDirection = "Up" } },
    { key = "l", mods = "LEADER", action = act { ActivatePaneDirection = "Right" } },
    { key = "H", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Left", 5 } } },
    { key = "J", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Down", 5 } } },
    { key = "K", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Up", 5 } } },
    { key = "L", mods = "LEADER|SHIFT", action = act { AdjustPaneSize = { "Right", 5 } } },
    { key = "1", mods = "LEADER", action = act { ActivateTab = 0 } },
    { key = "2", mods = "LEADER", action = act { ActivateTab = 1 } },
    { key = "3", mods = "LEADER", action = act { ActivateTab = 2 } },
    { key = "4", mods = "LEADER", action = act { ActivateTab = 3 } },
    { key = "5", mods = "LEADER", action = act { ActivateTab = 4 } },
    { key = "6", mods = "LEADER", action = act { ActivateTab = 5 } },
    { key = "7", mods = "LEADER", action = act { ActivateTab = 6 } },
    { key = "8", mods = "LEADER", action = act { ActivateTab = 7 } },
    { key = "9", mods = "LEADER", action = act { ActivateTab = 8 } },
    { key = "&", mods = "LEADER|SHIFT", action = act { CloseCurrentTab = { confirm = true } } },
    { key = "x", mods = "LEADER", action = act { CloseCurrentPane = { confirm = true } } },
    { key = "q", mods = "LEADER|CTRL", action = act.PaneSelect },
    { key = "s", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
    {
      key = "S",
      mods = "LEADER|SHIFT",
      action = act.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = "Bold" } },
          { Text = "Enter name for new workspace" },
        },
        action = wezterm.action_callback(function(window, pane, line)
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
    {
      key = "$",
      mods = "LEADER|SHIFT",
      action = act.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = "Bold" } },
          { Text = "Rename workspace" },
        },
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
          end
        end),
      },
    },
    {
      key = ",",
      mods = "LEADER",
      action = act.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = "Bold" } },
          { Text = "Rename tab" },
        },
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
    {
      key = "u",
      mods = "LEADER|CTRL",
      action = wezterm.action.CharSelect {
        copy_on_select = true,
        copy_to = "ClipboardAndPrimarySelection",
      },
    },
  }

  if wezterm.gui then
    local copy_mode = nil
    local search_mode = nil
    -- override copy mode keys
    copy_mode = wezterm.gui.default_key_tables().copy_mode
    local copy_override = {
      { key = "?", mods = "SHIFT", action = act.Search { CaseSensitiveString = "" } },
      { key = "B", mods = "NONE", action = act.CopyMode "MoveBackwardWord" },
      { key = "W", mods = "NONE", action = act.CopyMode "MoveForwardWord" },
      { key = "E", mods = "NONE", action = act.CopyMode "MoveForwardWordEnd" },
    }
    for _, key in ipairs(copy_override) do
      table.insert(copy_mode, key)
    end

    -- override search mode keys
    search_mode = wezterm.gui.default_key_tables().search_mode
    local search_override = {
      { key = "Enter", mods = "NONE", action = act.CopyMode "AcceptPattern" },
      { key = "u", mods = "CTRL", action = act.CopyMode "ClearPattern" },
    }
    for _, key in ipairs(search_override) do
      table.insert(search_mode, key)
    end

    config.key_tables = {
      copy_mode = copy_mode,
      search_mode = search_mode,
    }
  end
end

return M
