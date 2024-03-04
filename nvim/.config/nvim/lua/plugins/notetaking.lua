package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

return {
  {
    "benlubas/molten-nvim",
    lazy = true,
    version = "^1.0.0",     -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    "folke/zen-mode.nvim",
    lazy = true,
    opts = {
      plugins = {
        twilight = { enabled = true },  -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = true },      -- disables the tmux statusline
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
    enabled = true, -- it is somewhat buggy
    lazy = true,
    build = "luarocks --local --lua-version 5.1 install magick",
    event = { "BufEnter *.norg" },
    config = function()
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
        max_width = 100,
        max_height = 12,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true,                                      -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
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
          ["core.defaults"] = {},        -- Loads default behaviour
          -- ["core.integrations.image"] = {}, -- draw images
          ["core.summary"] = {},         -- create index files
          ["core.export.markdown"] = {}, -- markdown export
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },                         -- completion engine
          -- calendar requires nvim > 0.10.0
          ["core.ui.calendar"] = {}, -- calendar widget
          ["core.presenter"] = {
            config = {
              zen_mode = "zen-mode",
            },
          },                                    -- presentation mode
          ["core.integrations.telescope"] = {}, -- telescope plugin
          ["core.concealer"] = {
            config = {
              icon_preset = "varied",
            },
          },                  -- Adds pretty icons to your documents
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

      -- default keybinds
      local neorg_callbacks = require("neorg.core.callbacks")

      neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
          i = { -- Bind in insert mode
            { "<C-l>", "core.integrations.telescope.insert_link" },
          },
        }, {
          silent = true,
          noremap = true,
        })
      end)

      -- global keybinds
      local neorg_keys = {
        ["<leader>n"] = {
          name = "+neorg",
          w = { "<cmd>lua vim.cmd('Neorg workspace work')<cr>", "Workspace work" },
          n = { "<cmd>lua vim.cmd('Neorg workspace notes')<cr>", "Workspace notes" },
          c = { "<cmd>lua require('neorg').modules.get_module('core.ui.calendar').select_date({})<cr>", "Date picker" },
          j = { "<cmd>lua vim.cmd('Neorg journal today')<cr>", "Journal today" },
          M = {
            "<cmd>"
            .. "lua vim.api.nvim_buf_set_text(0, 1, 7, 1, 17, { os.date('%Y-%m-%d') });"
            .. "vim.api.nvim_buf_set_text(0, 8, 9, 8, 33, { os.date('%Y-%m-%dT%H:%M:%S%z') });"
            .. "vim.api.nvim_buf_set_text(0, 12, 2, 12, 12, { os.date('%Y-%m-%d') })"
            .. "<cr>",
            "Update Meta",
          },
          r = { "<cmd>lua vim.cmd('Neorg return')<cr>", "Journal tomorrow" },
          t = { "<cmd>lua vim.cmd('Neorg journal tomorrow')<cr>", "Journal tomorrow" },
          y = { "<cmd>lua vim.cmd('Neorg journal yesterday')<cr>", "Journal yesterday" },
          i = { "<cmd>lua vim.cmd('Neorg journal toc open')<cr>", "Journal index" },
          u = { "<cmd>lua vim.cmd('Neorg journal toc update')<cr>", "Journal toc update" },
          H = { "<cmd>lua vim.cmd('Telescope neorg search_headings')<cr>", "Neorg headings" },
          L = { "<cmd>lua vim.cmd('Telescope neorg find_linkable')<cr>", "Neorg linkable" },
        },
      }
      require("which-key").register({ mode = { "n" }, neorg_keys })
    end,
  },
}
