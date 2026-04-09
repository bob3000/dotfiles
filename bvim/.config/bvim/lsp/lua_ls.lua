return {
	-- cmd = { ... },
	-- filetypes = { ... },
	-- capabilities = {},
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"Snacks",
					"FzfLua",
					"vim",
				},
			},
			-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},
}
