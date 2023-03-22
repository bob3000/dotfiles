local M = {}

--- attach codelldb
---@param dap table nvim-dap object
M.setup = function(dap)
	local dbg_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/bin/codelldb")
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			-- CHANGE THIS to your path!
			command = dbg_path,
			args = { "--port", "${port}" },

			-- On windows you may have to uncomment this:
			-- detached = false,
		},
	}
	dap.configurations.rust = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
		{
			name = "Launch file with args",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = function()
				local args_string = vim.fn.input("Arguments: ")
				return vim.split(args_string, " +")
			end,
		},
	}
	dap.configurations.c = dap.configurations.rust
	dap.configurations.cpp = dap.configurations.rust
	dap.configurations.zig = {
		{
			type = "codelldb",
			request = "launch",
			name = "Launch File",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/zig-out/bin/", "file")
			end,
			args = { "/usr/bin/zig" },
			cwd = "${workspaceFolder}",
		},
	}
end

return M
