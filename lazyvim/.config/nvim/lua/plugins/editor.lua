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
    "folke/flash.nvim",
    enabled = false,
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
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = { config = { header = vim.split(logo, "\n") } },
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
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "overseer")
    end,
  },
  {
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      enabled = true,
      execution_message = {
        enabled = false,
      },
    },
    keys = {
      { "<leader>cS", "<cmd>ASToggle<cr>", desc = "Toggle Auto Save" },
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
  {
    "danymat/neogen",
    version = "*",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = { snippet_engine = "luasnip" },
    keys = {
      { "<leader>cg", "<cmd>Neogen<cr>", desc = "Generate Comment" },
    },
  },
}
