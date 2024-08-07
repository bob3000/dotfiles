package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

return {
  {
    "jakewvincent/mkdnflow.nvim",
    event = "VeryLazy",
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
        template = "# {{ title }}",
      },
      mappings = {
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
      },
    },
  },
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
    enabled = false, -- it is somewhat buggy
    lazy = true,
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
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
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
      })
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    lazy = false,
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    after = "nvim-treesitter",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          -- ["core.integrations.image"] = {}, -- draw images
          ["core.summary"] = {}, -- create index files
          ["core.export.markdown"] = {}, -- markdown export
          ["core.esupports.metagen"] = {
            config = {
              undojoin_updates = true,
            },
          },
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.map("norg", "n", "u", function()
                  require("neorg.modules.core.esupports.metagen.module").public.skip_next_update()
                  local k = vim.api.nvim_replace_termcodes("u<c-o>", true, false, true)
                  vim.api.nvim_feedkeys(k, "n", false)
                end)
                keybinds.map("norg", "n", "<c-r>", function()
                  require("neorg.modules.core.esupports.metagen.module").public.skip_next_update()
                  local k = vim.api.nvim_replace_termcodes("<c-r><c-o>", true, false, true)
                  vim.api.nvim_feedkeys(k, "n", false)
                end)
              end,
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          }, -- completion engine
          -- calendar requires nvim > 0.10.0
          ["core.ui.calendar"] = {}, -- calendar widget
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
      end, function(_) end)

      -- global keybinds
      local neorg_keys = {
        {
          { "<leader>n", group = "neorg" },
          { "<leader>nH", "<cmd>lua vim.cmd('Telescope neorg search_headings')<cr>", desc = "Neorg headings" },
          { "<leader>nL", "<cmd>lua vim.cmd('Telescope neorg find_linkable')<cr>", desc = "Neorg linkable" },
          {
            "<leader>nM",
            "<cmd>lua vim.api.nvim_buf_set_text(0, 1, 7, 1, 17, { os.date('%Y-%m-%d') });"
              .. "vim.api.nvim_buf_set_text(0, 8, 9, 8, 33, { os.date('%Y-%m-%dT%H:%M:%S%z') });"
              .. "vim.api.nvim_buf_set_text(0, 12, 2, 12, 12, { os.date('%Y-%m-%d') })<cr>",
            desc = "Update Meta",
          },
          {
            "<leader>nc",
            "<cmd>lua require('neorg').modules.get_module('core.ui.calendar').select_date({})<cr>",
            desc = "Date picker",
          },
          { "<leader>ni", "<cmd>lua vim.cmd('Neorg journal toc open')<cr>", desc = "Journal index" },
          { "<leader>nj", "<cmd>lua vim.cmd('Neorg journal today')<cr>", desc = "Journal today" },
          {
            "<leader>nl",
            "<cmd>lua vim.cmd('Neorg keybind all core.looking-glass.magnify-code-block')<cr>",
            desc = "Looking glass",
          },
          { "<leader>nm", "<cmd>lua vim.cmd('Neorg inject-metatdata')<cr>", desc = "Metadata inject" },
          { "<leader>nn", "<cmd>lua vim.cmd('Neorg workspace notes')<cr>", desc = "Workspace notes" },
          { "<leader>nr", "<cmd>lua vim.cmd('Neorg return')<cr>", desc = "Journal tomorrow" },
          { "<leader>nt", "<cmd>lua vim.cmd('Neorg journal tomorrow')<cr>", desc = "Journal tomorrow" },
          { "<leader>nu", "<cmd>lua vim.cmd('Neorg journal toc update')<cr>", desc = "Journal toc update" },
          { "<leader>nw", "<cmd>lua vim.cmd('Neorg workspace work')<cr>", desc = "Workspace work" },
          { "<leader>ny", "<cmd>lua vim.cmd('Neorg journal yesterday')<cr>", desc = "Journal yesterday" },
        },
      }
      require("which-key").add(neorg_keys)
    end,
  },
}
