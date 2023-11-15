return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    opts = {
      plugins = {
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = true }, -- disables the tmux statusline
        kitty = {
          enabled = true,
          font = "+4", -- font size increment
        },
        alacritty = {
          enabled = true,
          font = "14", -- font size
        },
        wezterm = {
          enabled = true,
          font = "+4", -- (10% increase per step)
        },
      },
    },
    keys = {
      { "<leader>Z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  {
    "3rd/image.nvim",
    build = "luarocks --local --lua-version 5.1 install magick",
    event = { "BufEnter *.norg" },
    config = function()
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
      package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

      require("image").setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
      })
    end,
  },
  {
    "nvim-neorg/neorg",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    build = ":Neorg sync-parsers",
    event = "VeryLazy",
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
      local neorg_keys = {
        ["<leader>n"] = {
          name = "+neorg",
          w = {
            "<cmd>lua if vim.bo.filetype=='norg' then vim.cmd('Neorg return') else vim.cmd('Neorg workspace work') end<cr>",
            "Workspace work",
          },
          j = { "<cmd>lua vim.cmd('Neorg journal today')<cr>", "Journal today" },
          M = {
            "<cmd>lua vim.api.nvim_buf_set_text(0, 1, 7, 1, 17, { os.date('%Y-%m-%d') });vim.api.nvim_buf_set_text(0, 8, 9, 8, 33, { os.date('%Y-%m-%dT%H:%M:%S%z') })<cr>",
            "Update Meta",
          },
          t = { "<cmd>lua vim.cmd('Neorg journal tomorrow')<cr>", "Journal tomorrow" },
          y = { "<cmd>lua vim.cmd('Neorg journal yesterday')<cr>", "Journal yesterday" },
          i = { "<cmd>lua vim.cmd('Neorg journal toc open')<cr>", "Journal index" },
          u = { "<cmd>lua vim.cmd('Neorg journal toc update')<cr>", "Journal toc update" },
          N = { "<cmd>Telescope neorg search_headings<cr>", "Neorg headings" },
        },
      }
      require("which-key").register({ mode = { "n" }, neorg_keys })
    end,
  },
}
