return {
  vim.pack.add({
    { src = "https://github.com/danymat/neogen", name = "neogen", version = vim.version.range("*") },
  }),
  vim.api.nvim_create_autocmd({ "BufCreate", "BufEnter" }, {
    callback = function()
      require("neogen").setup({})
      vim.keymap.set("n", "<leader>cn", function()
        require("neogen").generate()
      end, { desc = "Generate Annotations (Neogen)" })
    end,
  }),
}
