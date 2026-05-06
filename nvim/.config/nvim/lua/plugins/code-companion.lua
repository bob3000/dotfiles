---@class CodeCompanion.SystemPrompt.Context
---@field language string
---@field adapter CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter
---@field date string
---@field nvim_version string
---@field os string the operating system that the user is using
---@field default_system_prompt string
---@field cwd string current working directory
---The closest parent directory that contains one of the following VCS markers:
--- - `.git`
--- - `.svn`
--- - `.hg`
---@field project_root? string the closest parent directory that contains a `.git` subdirectory.
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
return {
  {
    'olimorris/codecompanion.nvim',
    enabled = true,
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
    opts = {
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
