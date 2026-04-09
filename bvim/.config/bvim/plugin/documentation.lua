return {
  vim.pack.add({
    { src = "https://github.com/jakewvincent/mkdnflow.nvim", version = vim.version.range("*") },
    { src = "https://github.com/iamcco/markdown-preview.nvim", version = vim.version.range("*") },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", version = vim.version.range("*") },
  }),
  vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
      local name = ev.data.spec.name
      if name == "markdown-preview" then
        vim.fn["mkdp#util#install"]()
      end
    end,
  }),
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "markdown",
    },
    callback = function()
      require("mkdnflow").setup({
        modules = {
          yaml = true,
          completion = false,
        },
        links = {
          conceal = true,
          transform_implicit = true,
        },
        new_file_template = {
          use_template = true,
          template = "# {{ title }} - {{ date }}\n",
        },
        mappings = {
          MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>Np" }, -- see MkdnEnter
          MkdnUpdateNumbering = { "n", "<leader>Nn" },
          MkdnTableNewRowBelow = { "n", "<leader>Nr" },
          MkdnTableNewRowAbove = { "n", "<leader>NR" },
          MkdnTableNewColAfter = { "n", "<leader>Nc" },
          MkdnTableNewColBefore = { "n", "<leader>NC" },
          MkdnFoldSection = { "n", "<leader>Nf" },
          MkdnUnfoldSection = { "n", "<leader>NF" },
        },
      })

      vim.keymap.set("n", "<leader>Ni", "<cmd>e ~/Nextcloud/Synced/wiki/index.md<CR>", { desc = "Notes index" })
      vim.keymap.set("n", "<leader>Nl", "<cmd>e ~/Nextcloud/Synced/wiki/2026-01-05_2026.md<CR>", { desc = "Notes" })

      require("render-markdown").setup({
        code = {
          sign = false,
          width = "block",
          right_pad = 1,
        },
        heading = {
          sign = false,
          icons = {},
        },
        checkbox = {
          enabled = false,
        },
      })
      vim.cmd([[do FileType]])
    end,
  }),
}
