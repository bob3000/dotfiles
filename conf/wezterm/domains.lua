local M = {}
M.setup = function(config, wezterm)
	local mux = wezterm.mux
	-- Decide whether cmd represents a default startup invocation
	local function is_default_startup(cmd)
		if not cmd then
			-- we were started with `wezterm` or `wezterm start` with
			-- no other arguments
			return true
		end
		if cmd.domain == "DefaultDomain" and not cmd.args then
			-- Launched via `wezterm start --cwd something`
			return true
		end
		-- we were launched some other way
		return false
	end

	config.unix_domains = {
		{
			name = "unix",
		},
	}
	config.default_gui_startup_args = { "connect", "unix" }
	config.mux_env_remove = {
		"SSH_CLIENT",
		"SSH_CONNECTION",
	}
	wezterm.on("gui-startup", function(cmd)
		if not is_default_startup(cmd) then
			-- for the default startup case, we want to switch to the unix domain instead
			local unix = mux.get_domain("unix")
			mux.set_default_domain(unix)
			-- ensure that it is attached
			unix:attach()
		end
	end)
end

return M
