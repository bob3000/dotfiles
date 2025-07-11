-- [[ Configure and install plugins ]]
--
return {
  {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    opts = {},
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    keys = {
      -- code
      { '<leader>cw', '<cmd>%s/ \\+$//<CR>', mode = '', desc = 'Remove trailing whitespace' },
      { '<leader>co', ":'<,'>sort<CR>", mode = '', desc = 'Order lines' },

      -- marks
      { 'dm', ":execute 'delmarks '.nr2char(getchar())<CR>", mode = '', desc = 'Delete mark' },
      { 'dm*', ":execute 'delmarks!'<CR>", mode = '', desc = 'Delete all marks' },
    },
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 200,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
      },

      -- Document existing key chains
      spec = {
        { '<leader>b', group = 'Buffers', icon = '' },
        { '<leader>c', group = 'Code', icon = '' },
        { '<leader>d', group = 'Debug', icon = '' },
        { '<leader>f', group = 'Find', icon = '󰈞' },
        { '<leader>g', group = 'Git', icon = '' },
        { '<leader>h', group = 'Git Hunk', icon = '', mode = { 'n', 'v' } },
        { '<leader>o', group = 'Overseer', icon = '' },
        { '<leader>q', group = 'Session', icon = '' },
        { '<leader>s', group = 'Search', icon = '󰍉' },
        { '<leader>t', group = 'Test', icon = '▶' },
        { '<leader>u', group = 'Ui', icon = '' },
        { '<leader>x', group = 'Trouble', icon = '' },
      },
    },
  },
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
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
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
  {
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has 'nvim-0.10.0' == 1,
  },
  {
    'kylechui/nvim-surround',
    version = '^3.0.0', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    opts = {},
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {},
    keys = {
      { '<leader>qs', '', desc = 'Session load current' },
      { '<leader>qS', '', desc = 'Session select' },
      { '<leader>ql', '', desc = 'Session load last' },
      { '<leader>qd', '', desc = 'Session no save' },
    },
  },
}
