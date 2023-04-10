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
	local meth_ok, _ = pcall(mod[method], unpack(...))
	if not meth_ok then
		-- turn on for debugging
		-- vim.notify("[warn] method " .. method .. " not found on module " .. module, vim.log.levels.WARN)
		return
	end
end

try_setup("auto-save", "setup", {})
try_setup("neogen", "setup", {})
try_setup("spectre", "setup", {})
try_setup("colorizer", "setup", {})
try_setup("cinnamon", "setup", {})
try_setup("symbols-outline", "setup", {})
try_setup("marks", "setup", {})
try_setup("neogen", "setup", { { snippet_engine = "luasnip" } })
try_setup("nvim-ts-autotag", "setup", {})
try_setup("nvim-ts-autotag", "setup", {})
try_setup("crates", "setup", {})
try_setup("dap-python", "setup", { "python", {} })
try_setup("lsp_signature", "setup", {})
try_setup("fidget", "setup", {})
try_setup("dap-go", "setup", {})
try_setup("texmagic", "setup", {})
try_setup("package-info", "setup", { { package_manager = "npm" } })
