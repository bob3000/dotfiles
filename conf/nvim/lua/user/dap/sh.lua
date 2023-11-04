local M = {}
--- attach codelldb
---@param dap table nvim-dap object
M.setup = function(dap)
  local bin_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/bin/bash-debug-adapter")
  local pkg_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir")
  dap.adapters.sh = {
    type = "executable",
    command = bin_path,
  }
  dap.configurations.sh = {
    {
      name = "Launch Bash debugger",
      type = "sh",
      request = "launch",
      program = "${file}",
      cwd = "${fileDirname}",
      pathBashdb = pkg_path .. "/bashdb",
      pathBashdbLib = pkg_path,
      pathBash = "bash",
      pathCat = "cat",
      pathMkfifo = "mkfifo",
      pathPkill = "pkill",
      env = {},
      args = {},
      -- showDebugOutput = true,
      -- trace = true,
    },
  }
end

return M
