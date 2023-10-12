 -- 5.1 compatibility
table.unpack = table.unpack or unpack

--- protected setup call
---@param module string module to call on
---@param method string method to be called
---@param ... table to the method
local function try_setup(module, method, ...)
  local mod_ok, mod = pcall(require, module)
  if not mod_ok then
    -- turn on for debugging
    -- vim.notify("[warn] module " .. module .. " not found", vim.log.levels.WARN)
    return
  end
  local meth_ok, _ = pcall(mod[method], table.unpack(...))
  if not meth_ok then
    -- turn on for debugging
    -- vim.notify("[warn] method " .. method .. " not found on module " .. module, vim.log.levels.WARN)
    return
  end
end

try_setup("neogen", "setup", {})
try_setup("spectre", "setup", {})
try_setup("colorizer", "setup", {})
try_setup("symbols-outline", "setup", { { auto_close = true } })
try_setup("marks", "setup", {})
try_setup("neogen", "setup", { { snippet_engine = "luasnip" } })
try_setup("nvim-ts-autotag", "setup", {})
try_setup("nvim-ts-autotag", "setup", {})
try_setup("dap-python", "setup", { "python", {} })
try_setup("lsp_signature", "setup", {})
try_setup("dap-go", "setup", {})
try_setup("texmagic", "setup", {})
try_setup("dressing", "setup", {})
try_setup("package-info", "setup", { { package_manager = "npm" } })
try_setup("refactoring", "setup", {})
if vim.fn.has("gui_running") ~= 1 then
  try_setup("cinnamon", "setup", {})
end
