return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.summary"] = {}, -- create index files
          ["core.export.markdown"] = {}, -- markdown export
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          }, -- completion engine
          -- calendar requires nvim > 0.10.0
          -- ["core.ui.calendar"] = {}, -- calendar widget
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            },
          }, -- presentation mode
          ["core.integrations.telescope"] = {}, -- telescope plugin
          ["core.concealer"] = {
            config = {
              icon_preset = "varied",
            },
          }, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Nextcloud/Synced/neorg/workspaces/notes",
                work = "~/Nextcloud/Synced/neorg/workspaces/work",
                default_workspace = "work",
              },
            },
          },
        },
      })
      require("telescope").load_extension("neorg")
      local keys = {
        ["<leader>n"] = {
          name = "+neorg",
          w = {
            "<cmd>lua if vim.bo.filetype=='norg' then vim.cmd('Neorg return') else vim.cmd('Neorg workspace work') end<cr>",
            "Workspace work",
          },
          j = { "<cmd>lua vim.cmd('Neorg journal today')<cr>", "Journal today" },
          t = { "<cmd>lua vim.cmd('Neorg journal tomorrow')<cr>", "Journal tomorrow" },
          y = { "<cmd>lua vim.cmd('Neorg journal yesterday')<cr>", "Journal yesterday" },
          i = { "<cmd>lua vim.cmd('Neorg journal toc open')<cr>", "Journal index" },
          u = { "<cmd>lua vim.cmd('Neorg journal toc update')<cr>", "Journal toc update" },
          N = { "<cmd>Telescope neorg search_headings<cr>", "Neorg headings" },
        },
      }
      require("which-key").register({ mode = { "n" }, keys })
    end,
  },
}
