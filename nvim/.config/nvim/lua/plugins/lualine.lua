local icons = require 'config.icons'
return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = {
          statusline = {
            'snacks_dashboard',
          },
          winbar = {
            'snacks_dashboard',
          },
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
        lualine_c = { 'filename', 'aerial' },
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
    },
  },
}
