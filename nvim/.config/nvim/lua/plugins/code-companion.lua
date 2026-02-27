-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
return {
  {
    'olimorris/codecompanion.nvim',
    lazy = false,
    version = '*',
    depedendencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      {
        '<leader>cc',
        '<cmd>CodeCompanionChat Toggle<cr>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionChat',
      },
      {
        '<leader>cA',
        '<cmd>CodeCompanionChat Add<cr>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionChat Add',
      },
      {
        '<leader>ca',
        '<cmd>CodeCompanionActions<cr>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionActions',
      },
    },
    config = {
      strategies = {
        chat = {
          adapter = 'ollama',
        },
        inline = {
          adapter = 'ollama',
        },
        cmd = {
          adapter = 'ollama',
        },
        background = {
          adapter = 'ollama',
        },
      },
    },
  },
}
