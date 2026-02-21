local logo = [[
         .:           ..           
       .----.         :==.         
     .-------:        :====:       
    ::-===-----       :======      
    :---==------.     :+++++=      
    :-----=------:    :++++++      
    ------::-------   :++++++      
    ------. :-------. :++++++      
    ------:  .-======::++++++      
    ------:    -=======++++++      
    -=====:     :======++++++      
    -=====:      .=====++++++      
     :====:        -===++++=.      
       :==:         :==++=.        
         -:          .==.          
]]

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
  { 'nvim-mini/mini.pairs', version = false, opts = {} },
  { 'nvim-mini/mini.surround', version = false, opts = {} },
  {
    'nvim-mini/mini.animate',
    version = false,
    opts = {
      -- Cursor path
      cursor = {
        -- Whether to enable this animation
        enable = false,
      },
    },
  },
  {
    'nvim-mini/mini.notify',
    version = false,
    opts = {},
    keys = {
      {
        '<leader>n',
        function()
          MiniNotify.show_history()
        end,
        desc = 'Notification history',
      },
    },
  },
  {
    'nvim-mini/mini.starter',
    version = false,
    opts = function()
      local starter = require 'mini.starter'
      return {
        evaluate_single = true,
        header = logo,
        footer = '',
        items = {
          { action = ':Oil', name = 'Explore', section = '' },
          { action = ':FzfLua files', name = 'Find', section = '' },
          { action = ':FzfLua live_grep', name = 'Grep', section = '' },
          { action = ':Lazy', name = 'Lazy', section = '' },
          { action = ':Mason', name = 'Mason', section = '' },
          { action = ':quit', name = 'Quit', section = '' },
          -- Use this if you set up 'mini.sessions'
          starter.sections.sessions(5, true),
        },
      }
    end,
  },
  { 'nvim-mini/mini.sessions', version = false, opts = {} },
  { 'nvim-mini/mini.bufremove', version = false, opts = {} },
  { 'nvim-mini/mini.indentscope', version = false, opts = {
    symbol = '┊',
  } },
}
