local function try_setup(module, method, options)
	local mod_ok, mod = pcall(require, module)
	if not mod_ok then
		vim.notify("[warn] module " .. module .. " not found")
		return
	end
	local meth_ok, _ = pcall(mod[method], options)
	if not meth_ok then
		vim.notify("[warn] method " .. method .. " not found on module " .. module)
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
try_setup("neogen", "setup", {})
try_setup("nvim-ts-autotag", "setup", {})
try_setup("nvim-ts-autotag", "setup", {})
try_setup("crates", "setup", {})
try_setup("mkdnflow", "setup", {})
try_setup("dap-python", "setup", { "python", {} })
try_setup("lsp_signature", "setup", {})
