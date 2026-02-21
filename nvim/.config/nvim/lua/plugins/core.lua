return {
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
}
