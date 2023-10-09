local status_ok, crates = pcall(require, "crates")
if not status_ok then
  vim.notify("not loaded")
  return
end

crates.setup({

  src = {
    cmp = {
      enabled = true,
    },
  },
  null_ls = {
    enabled = true,
    name = "crates.nvim",
  },
})
