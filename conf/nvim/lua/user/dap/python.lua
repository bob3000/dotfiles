local M = {}

--- attach debugpy
---@param dap table nvim-dap object
M.setup = function(dap)
	-- local dbg_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason")

  local venvPath = ""
  if os.execute("test -f pyproject.toml") == 0 then
    venvPath = io.popen("poetry env info --path"):read("l")
  end

  -- input module name to debug
  local modName = ""
  local function moduleName()
    return vim.fn.input("module name: ")
  end

	dap.configurations.python = {
		{
			name = "Poetry PyTest",
			type = "python",
			request = "launch",
			program = venvPath .. "/bin/pytest",
			reAttach = true,
			cwd = "${workspaceFolder}",
			args = { "${file}" },
		},
		{
			name = "Poetry module",
      module = moduleName,
			type = "python",
			request = "launch",
      python = venvPath .. "/bin/python",
			reAttach = true,
			cwd = "${workspaceFolder}",
			args = { "poetry", "run", modName },
		},
	}
end

return M
