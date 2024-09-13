local wk = require("which-key")
local telescope = require("telescope.builtin")

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
            telescope.live_grep()
          end,
          desc = "Search notes",
        },
      })
    end,
    opts = {
      modules = {
        yaml = true,
        cmp = true,
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
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
      },
    },
  },
}
