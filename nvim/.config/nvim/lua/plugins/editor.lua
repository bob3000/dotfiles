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
    "https://codeberg.org/esensar/nvim-dev-container",
    lazy = true,
    event = "VeryLazy",
    opts = {
      autocommands = {
        -- can be set to true to automatically start containers when devcontainer.json is available
        init = false,
        -- can be set to true to automatically remove any started containers and any built images when exiting vim
        clean = false,
        -- can be set to true to automatically restart containers when devcontainer.json file is updated
        update = false,
      },
      -- can be changed to increase or decrease logging from library
      log_level = "info",
      attach_mounts = {
        neovim_config = {
          -- enables mounting local config to /root/.config/nvim in container
          enabled = false,
          -- makes mount readonly in container
          options = { "readonly" },
        },
        neovim_data = {
          -- enables mounting local data to /root/.local/share/nvim in container
          enabled = false,
          -- no options by default
          options = {},
        },
        -- Only useful if using neovim 0.8.0+
        neovim_state = {
          -- enables mounting local state to /root/.local/state/nvim in container
          enabled = false,
          -- no options by default
          options = {},
        },
      },
      -- This takes a string (usually either "podman" or "docker") representing container runtime - "devcontainer-cli" is also partially supported
      -- That is the command that will be invoked for container operations
      -- If it is nil, plugin will use whatever is available (trying "podman" first)
      container_runtime = "docker",
      -- Similar to container runtime, but will be used if main runtime does not support an action - useful for "devcontainer-cli"
      backup_runtime = "podman",
      -- This takes a string (usually either "podman-compose" or "docker-compose") representing compose command - "devcontainer-cli" is also partially supported
      -- That is the command that will be invoked for compose operations
      -- If it is nil, plugin will use whatever is available (trying "podman-compose" first)
      compose_command = nil,
      -- Similar to compose command, but will be used if main command does not support an action - useful for "devcontainer-cli"
      backup_compose_command = nil,
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
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader><space>", "<cmd>BufferLinePick<CR>", desc = "Pick Buffer" },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
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
