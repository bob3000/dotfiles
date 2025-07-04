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
    },
    keys = {
      {
        '<leader>ca',
        '<cmd>AerialToggle!<cr>',
        desc = '[A]erial',
      },
    },
  },
}
