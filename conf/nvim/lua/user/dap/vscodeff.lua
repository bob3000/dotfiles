local M = {}

--- attach js-debug-adapter
---@param dap table nvim-dap object
M.setup = function(dap)
  local dbg_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason")

  dap.adapters.firefox = {
    type = "executable",
    command = dbg_path .. "/bin/firefox-debug-adapter",
  }

  for _, language in ipairs { "typescript", "typescriptreact", "javascript" } do
    dap.configurations[language] = {
      {
        name = "Debug with Firefox",
        type = "firefox",
        request = "launch",
        reAttach = true,
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        firefoxExecutable = "/usr/bin/firefox-developer-edition",
      },
    }
  end
end

return M
