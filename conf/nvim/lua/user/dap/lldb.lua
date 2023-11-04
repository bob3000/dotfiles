local M = {}

--- attach codelldb
---@param dap table nvim-dap object
M.setup = function(dap)
  local dbg_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/bin/codelldb")
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
      name = "Launch tests",
      type = "codelldb",
      request = "launch",
      program = function()
        local command =
          "ls -1t --indicator-style=slash $(cargo test --no-run --message-format=json | jq -r 'select(.profile.test == true) | .filenames[]') | head -n1"
        local handle = io.popen(command)
        if handle ~= nil then
          local result = handle:read "*a"
          handle:close()
          return vim.trim(result)
        end
        vim.notify "could not find test to debug"
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "Launch main",
      type = "codelldb",
      request = "launch",
      program = function()
        local exe = vim.fs.basename(vim.fn.getcwd())
        vim.notify(exe)
        return "${workspaceFolder}/target/debug/" .. exe
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
    {
      name = "Launch main with args",
      type = "codelldb",
      request = "launch",
      program = function()
        local exe = vim.fs.basename(vim.fn.getcwd())
        vim.notify(exe)
        return "${workspaceFolder}/target/debug/" .. exe
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = function()
        local args_string = vim.fn.input "Arguments: "
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
