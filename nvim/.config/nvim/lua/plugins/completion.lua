return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.completion, { autocomplete = vim.g.enable_autocomplete })
      table.insert(opts.sources, { name = "emoji" })
      table.insert(opts.sources, { name = "mkdnflow" })
    end,
  },
}
