local logo = [[
         .:           ..           
       .----.         :==.         
     .-------:        :====:       
    ::-===-----       :======      
    :---==------.     :+++++=      
    :-----=------:    :++++++      
    ------::-------   :++++++      
    ------. :-------. :++++++      
    ------:  .-======::++++++      
    ------:    -=======++++++      
    -=====:     :======++++++      
    -=====:      .=====++++++      
     :====:        -===++++=.      
       :==:         :==++=.        
         -:          .==.          
]]

logo = string.rep("\n", 8) .. logo .. "\n\n"

return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        cwd_target = {
          sidebar = "tab", -- sidebar is when position = left or right
          current = "window", -- current is when position = current
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      popup_border_style = "NC",
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      layout = {
        max_width = { 50, 0.3 },
        min_width = 20,
        resize_to_content = true,
      },
      close_on_select = true,
      show_guides = true,
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = false, -- whether or not tab names should be truncated
      },
    },
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    opts = {
      messages = {
        enabled = true, -- enables the Noice messages UI
        view = "mini", -- default view for messages
        view_error = "mini", -- view for errors
        view_warn = "mini", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "*",
    config = function()
      local colors = require("helper.colors").get_colors()
      require("window-picker").setup({
        hint = "floating-big-letter",
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "OverseerList" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
        highlights = {
          statusline = {
            focused = {
              fg = colors.fg,
              bg = colors.bg5,
              bold = true,
            },
            unfocused = {
              fg = colors.fg,
              bg = colors.bg5,
              bold = true,
            },
          },
          winbar = {
            focused = {
              fg = colors.fg,
              bg = colors.bg5,
              bold = true,
            },
            unfocused = {
              fg = colors.fg,
              bg = colors.bg5,
              bold = true,
            },
          },
        },
      })
    end,
  },
  {
    "NvChad/nvim-colorizer.lua",
    enabled = false,
    event = { "VeryLazy" },
    config = true,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    config = true,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = logo,
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "overseer")
      table.insert(opts.sections.lualine_x, "encoding")
      table.insert(opts.sections.lualine_x, "fileformat")
      table.insert(
        opts.sections.lualine_z,
        "vim.tbl_contains({'v', 'V'}, vim.fn.mode()) and string.format('%d words', vim.fn.wordcount()['visual_words'])"
      )
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      enabled = true,
    },
    keys = {
      { "<leader>cW", "<cmd>ASToggle<cr>", desc = "Toggle Auto Save" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
      },
    },
  },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     max_count = 10,
  --     disable_mouse = false,
  --     disabled_keys = {
  --       ["<Up>"] = {},
  --       ["<Down>"] = {},
  --       ["<Left>"] = {},
  --       ["<Right>"] = {},
  --     },
  --     restriction_mode = "block",
  --   },
  -- },
  {
    "ahmedkhalf/project.nvim",
    keys = {
      { "<leader>P", "<cmd>AddProject<cr>", desc = "Project add" },
    },
  },
}
