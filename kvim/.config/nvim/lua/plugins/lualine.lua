return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sections = {
        lualine_c = { 'aerial' },
        lualine_z = {
          "vim.tbl_contains({'v', 'V'}, vim.fn.mode()) and string.format('%d words', vim.fn.wordcount()['visual_words'])",
          "lsp_status",
        },
      },
    },
  },
}
