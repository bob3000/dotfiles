local M = {}

--- attach js-debug-adapter
---@param dap table nvim-dap object
M.setup = function(dap)
	local lazy_path = vim.fn.glob(vim.fn.stdpath("data") .. "/lazy")
	local dap_js_ok, dap_js = pcall(require, "dap-vscode-js")
	if dap_js_ok then
		-- look for mocha locally and globally
    -- TODO: move mocha detection to ftp
		local mocha = nil
		if os.execute("test -f ./node_modules/mocha/bin/mocha.js") == 0 then
			mocha = "./node_modules/mocha/bin/mocha.js"
		elseif os.execute("which mocha 2> /dev/null") == 0 then
			mocha = io.popen("which mocha"):read("l")
		end

		dap_js.setup({
			-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
			debugger_path = lazy_path .. "/vscode-js-debug", -- Path to vscode-js-debug installation.
			-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
			-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
			-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
		})

		for _, language in ipairs({ "typescript", "typescriptreact", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Mocha Tests",
					-- trace = true, -- include debugger info
					runtimeExecutable = "node",
					runtimeArgs = { mocha, "${file}" },
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = 'Start Chrome with "localhost"',
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					userDataDir = "${workspaceFolder}/.vscode-oss/vscode-chrome-debug-userdatadir",
				},
			}
		end
	end
end

return M
