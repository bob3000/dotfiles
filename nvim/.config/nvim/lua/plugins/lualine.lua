local icons = require 'config.icons'
local ignore_filetypes = require("config.tools").ignore_filetypes
return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        always_show_tabline = true,
        disabled_filetypes = {
          statusline = {
            'snacks_dashboard',
          },
          winbar = ignore_filetypes,
        },
      },
      sections = {
        lualine_b = {
          'branch',
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          'diagnostics',
        },
        lualine_c = {},
        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
          'overseer',
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
            color = function()
              return { fg = Snacks.util.color 'Debug' }
            end,
          },
        },
        lualine_z = {
          'location',
          {
            function()
              if vim.tbl_contains({ 'v', 'V' }, vim.fn.mode()) then
                return string.format('%d words', vim.fn.wordcount()['visual_words'])
              end
              return ''
            end,
          },
          'lsp_status',
        },
      },
      winbar = {
        lualine_c = {
          {
            'filename',
            newfile_status = true,
            symbols = {
              modified = '', -- Text to show when the file is modified
              readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '󰘓 ', -- Text to show for unnamed buffers.
              newfile = ' ', -- Text to show for newly created file before first write
            },
          },
          'aerial',
        },
      },
      inactive_winbar = {
        lualine_c = {
          {
            'filename',
            newfile_status = true,
            symbols = {
              modified = '', -- Text to show when the file is modified
              readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
              unnamed = '[No Name]', -- Text to show for unnamed buffers.
              newfile = '[New]', -- Text to show for newly created file before first write
            },
          },

          'aerial',
        },
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            use_mode_colors = false,
            cond = function()
              return vim.bo.filetype ~= 'snacks_dashboard'
            end,
            filetype_names = {
              snacks_picker_input = 'Picker',
              snacks_picker_list = 'Picker',
            },
            symbols = {
              modified = ' ●', -- Text to show when the buffer is modified
              alternate_file = ' ', -- Text to show to identify the alternate file
              directory = '', -- Text to show when the buffer is a directory
            },
          },
        },
        lualine_z = {
          {
            'tabs',
            cond = function()
              return vim.bo.filetype ~= 'snacks_dashboard'
            end,
            show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
            symbols = {
              modified = ' ●', -- Text to show when the file is modified
            },
          },
        },
      },
    },
  },
}
