-- get new exciting schema at
-- https://www.schemastore.org/json/

local function extend(tab1, tab2)
	for _, value in ipairs(tab2 or {}) do
		table.insert(tab1, value)
	end
	return tab1
end

local default_schemas = {}
local schemas = {}
local status_ok, schemastore = pcall(require, "schemastore")
if status_ok then
	schemas = schemastore.json.schemas()
end

local extended_schemas = extend(schemas, default_schemas)

local opts = {
	settings = {
		json = {
			schemas = extended_schemas,
			validate = { enable = true },
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}

return opts
