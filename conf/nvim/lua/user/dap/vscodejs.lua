local M = {}

--- attach js-debug-adapter
---@param dap table nvim-dap object
M.setup = function(dap)
	local dbg_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason")
	local dap_js_ok, dap_js = pcall(require, "dap-vscode-js")
	if dap_js_ok then
		dap_js.setup({
			-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
			debugger_path = dbg_path .. "/bin/js-debug-adapter", -- Path to vscode-js-debug installation.
			debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
			-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
			-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
		})

		for _, language in ipairs({ "typescript", "typescriptreact", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-chrome",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			}
		end
	end
end

return M
