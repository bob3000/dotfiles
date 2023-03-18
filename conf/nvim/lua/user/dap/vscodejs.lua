local M = {}

--- attach js-debug-adapter
---@param dap table nvim-dap object
M.setup = function(dap)
	local lazy_path = vim.fn.glob(vim.fn.stdpath("data") .. "/lazy")
	local dap_js_ok, dap_js = pcall(require, "dap-vscode-js")
	if dap_js_ok then
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
					name = "Node Mocha file",
					-- trace = true, -- include debugger info
					runtimeExecutable = "node",
					runtimeArgs = { "mocha", "${file}" },
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Node Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Node Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Deno Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
					runtimeExecutable = "deno",
					attachSimplePort = 9229,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Deno Launch file",
					cwd = "${workspaceFolder}",
					program = "${file}",
					runtimeExecutable = "deno",
					runtimeArgs = { "run", "-A", "--inspect-brk", "${file}" },
					attachSimplePort = 9229,
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Deno Test file",
					runtimeExecutable = "deno",
					cwd = "${workspaceFolder}",
					program = "${file}",
					runtimeArgs = { "test", "--inspect-brk" },
					attachSimplePort = 9229,
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = 'Start Chrome on "localhost:3000"',
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					userDataDir = "${workspaceFolder}/.vscode-oss/vscode-chrome-debug-userdatadir",
				},
			}
		end
	end
end

return M
