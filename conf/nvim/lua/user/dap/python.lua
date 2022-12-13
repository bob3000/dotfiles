local M = {}

--- attach debugpy
---@param dap table nvim-dap object
M.setup = function(dap)
	-- local dbg_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason")

	dap.configurations.python = {
		{
			name = "Launch file with predefined arguments",
			type = "python",
			request = "launch",
			program = "${file}",
			reAttach = true,
			args = { "arg", "arg2" },
		},
	}
end

return M
