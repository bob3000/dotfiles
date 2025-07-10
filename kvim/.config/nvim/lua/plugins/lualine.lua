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
              return ""
            end,
          },
          'lsp_status',
        },
      },
    },
  },
}
