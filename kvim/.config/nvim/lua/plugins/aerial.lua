local icons = require 'config.icons'
return {
  {
    'stevearc/aerial.nvim',
    lazy = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
      attach_mode = 'global',
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      show_guides = true,
      layout = {
        resize_to_content = false,
        win_opts = {
          winhl = 'Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB',
          signcolumn = 'yes',
          statuscolumn = ' ',
        },
      },
      guides = {
        mid_item = '├╴',
        last_item = '└╴',
        nested_top = '│ ',
        whitespace = '  ',
      },
    },
    keys = {
      {
        '<leader>cs',
        '<cmd>AerialToggle!<cr>',
        desc = 'Aerial',
      },
    },
  },
}
