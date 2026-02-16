return {
  {
    'nvim-mini/mini.clue',
    version = false,
    opts = function()
      local miniclue = require 'mini.clue'
      return {
        triggers = {
          -- Leader triggers
          { mode = { 'n', 'x' }, keys = '<Leader>' },

          -- `[` and `]` keys
          { mode = 'n', keys = '[' },
          { mode = 'n', keys = ']' },

          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = { 'n', 'x' }, keys = 'g' },

          -- Marks
          { mode = { 'n', 'x' }, keys = "'" },
          { mode = { 'n', 'x' }, keys = '`' },

          -- Registers
          { mode = { 'n', 'x' }, keys = '"' },
          { mode = { 'i', 'c' }, keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },

          -- `z` key
          { mode = { 'n', 'x' }, keys = 'z' },
        },

        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      }
    end,
  },
  -- Highlight todo, notes, etc in comments
  {
    'mikesmithgh/kitty-scrollback.nvim',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
    event = { 'User KittyScrollbackLaunch' },
    config = true,
  },
  {
    'okuuva/auto-save.nvim',
    cmd = 'ASToggle', -- optional for lazy loading on command
    event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
    opts = {
      enabled = true,
    },
    keys = {
      { '<leader>cW', '<cmd>ASToggle<cr>', desc = 'Toggle Auto Save' },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    version = '*',
    opts = {},
  },
  { 'nvim-mini/mini.pairs', version = false, opts = {} },
  { 'nvim-mini/mini.surround', version = false, opts = {} },
  { 'nvim-mini/mini.animate', version = false, opts = {} },
  { 'nvim-mini/mini.notify', version = false, opts = {} },
  { 'nvim-mini/mini.starter', version = false, opts = {} },
  { 'nvim-mini/mini.sessions', version = false, opts = {} },
}
