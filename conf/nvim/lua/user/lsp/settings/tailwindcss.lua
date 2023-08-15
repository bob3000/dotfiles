local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end
local util = lspconfig.util

return {
  root_dir = function(fname)
    return util.root_pattern "tailwind.config.ts"(fname)
      or util.root_pattern "tailwind.config.js"(fname)
      or util.root_pattern "tailwind.config.cjs"(fname)
  end,
  init_options = {
    lint = true,
  },
}
