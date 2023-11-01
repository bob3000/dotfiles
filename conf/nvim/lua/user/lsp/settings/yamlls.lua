local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return {}
end

local opts = {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = schemastore.yaml.schemas(),
    },
  },
}

return opts
