local wk = require("which-key")

return {
  {
    "jakewvincent/mkdnflow.nvim",
    event = "VeryLazy",
    keys = function()
      wk.add({
        { "<leader>n", group = "Note taking", icon = "📓" },
        { "<leader>ni", "<cmd>e ~/Nextcloud/Synced/wiki/index.md<CR>", desc = "Note index" },
        {
          "<leader>ns",
          function()
            vim.fn.chdir("~/Nextcloud/Synced/wiki")
            require("fzf-lua").live_grep()
          end,
          desc = "Search notes",
        },
      })
    end,
    opts = {
      modules = {
        yaml = true,
        cmp = false,
      },
      links = {
        conceal = true,
        transform_implicit = true,
      },
      new_file_template = {
        use_template = true,
        placeholders = {
          before = {
            title = "link_title",
            date = "os_date",
          },
          after = {},
        },
        template = "# {{ title }} - {{ date }}\n",
      },
      mappings = {
        MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>np" }, -- see MkdnEnter
        MkdnUpdateNumbering = { "n", "<leader>nn" },
        MkdnTableNewRowBelow = { "n", "<leader>nr" },
        MkdnTableNewRowAbove = { "n", "<leader>nR" },
        MkdnTableNewColAfter = { "n", "<leader>nc" },
        MkdnTableNewColBefore = { "n", "<leader>nC" },
        MkdnFoldSection = { "n", "<leader>nf" },
        MkdnUnfoldSection = { "n", "<leader>nF" },
      },
    },
  },
}
