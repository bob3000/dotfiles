local M = {}
M.setup = function(config, wezterm)
  local mux = wezterm.mux
  local path = os.getenv "PATH"
  if wezterm.target_triple == "aarch64-apple-darwin" or wezterm.target_triple == "x86_64-apple-darwin" then
    path = "/opt/homebrew/bin:" .. os.getenv "PATH"
  end

  wezterm.on("gui-startup", function(cmd)
    -- coding workspace
    local coding_dir = wezterm.home_dir .. "/code"
    local general_tab, general_pane, general_window = mux.spawn_window {
      workspace = "coding",
      cwd = coding_dir,
    }
    general_tab:set_title "shell"
    local term_pane_1 = general_pane:split {
      direction = "Right",
      size = 0.25,
      cwd = coding_dir,
    }

    local editor_tab, editor_pane, editor_window = general_window:spawn_tab {}
    editor_tab:set_title "editor"

    local cloud_tab, cloud_pane, cloud_window = general_window:spawn_tab {}
    cloud_tab:set_title "cloud"
    cloud_pane:split {
      direction = "Right",
    }

    local remote_tab, remote_pane, remote_window = general_window:spawn_tab {}
    remote_tab:set_title "remote"
    local remote_pane_1 = remote_pane:split {
      size = 0.666,
      direction = "Right",
    }
    local remote_pane_2 = remote_pane_1:split {
      size = 0.5,
      direction = "Right",
    }

    -- local workspace
    local local_dir = wezterm.home_dir .. "/code"
    local local_tab, local_pane, local_window = mux.spawn_window {
      workspace = "local",
      cwd = local_dir .. "/dotfiles",
    }
    local_tab:set_title "config"
    local_pane:split {
      direction = "Right",
      cwd = local_dir .. "/dotfiles",
    }

    mux.set_active_workspace "coding"
  end)
end

return M
