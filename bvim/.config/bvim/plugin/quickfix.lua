vim.pack.add({
  { src = "https://github.com/stevearc/quicker.nvim", version = vim.version.range("*") },
})

vim.schedule(function()
  require("quicker").setup({
    follow = {
      -- When quickfix window is open, scroll to closest item to the cursor
      enabled = true,
    },
  })

  vim.keymap.set("n", ">", function()
    require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
  end, { desc = "Expand quickfix context" })

  vim.keymap.set("n", "<", function()
    require("quicker").collapse()
  end, { desc = "Collapse quickfix context" })
end)
