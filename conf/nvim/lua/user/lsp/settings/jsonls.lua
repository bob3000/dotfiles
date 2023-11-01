local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return {}
end

local opts = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

return opts
