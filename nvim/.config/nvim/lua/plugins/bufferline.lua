return {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        highlights = require('catppuccin.special.bufferline').get_theme(),
        options = {
          diagnostics = 'nvim_lsp',
          always_show_bufferline = false,
          separator_style = 'slant',
          offsets = {
            {
              filetype = 'snacks_layout_box',
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>,', '<cmd>BufferLinePick<cr>', desc = 'Pick a buffer to open' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>', desc = 'Select a buffer to close' },
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '<S-A-h>', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { '<S-A-l>', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    },
  },
}
