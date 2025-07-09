return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
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
        lualine_x = { 'encoding', 'fileformat', 'filetype', 'overseer' },
        lualine_z = {
          'location',
          "vim.tbl_contains({'v', 'V'}, vim.fn.mode()) and string.format('%d words', vim.fn.wordcount()['visual_words'])",
          'lsp_status',
        },
      },
    },
  },
}
