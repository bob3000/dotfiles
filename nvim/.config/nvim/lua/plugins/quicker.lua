-- Improved quickfix UI.
return {
  {
    'stevearc/quicker.nvim',
    event = 'VeryLazy',
    opts = {
      follow = {
        -- When quickfix window is open, scroll to closest item to the cursor
        enabled = false,
      },
      -- Map of quickfix item type to icon
      type_icons = {
        E = '󰅚 ',
        W = '󰀪 ',
        I = ' ',
        N = ' ',
        H = ' ',
      },
    },
    keys = {
      {
        '<leader>xq',
        function()
          require('quicker').toggle()
        end,
        desc = 'Toggle quickfix',
      },
      {
        '<leader>xl',
        function()
          require('quicker').toggle({ loclist = true })
        end,
        desc = 'Toggle loclist list',
      },
      {
        '<leader>xd',
        function()
          local quicker = require('quicker')

          if quicker.is_open() then
            quicker.close()
          else
            vim.diagnostic.setqflist()
          end
        end,
        desc = 'Toggle diagnostics',
      },
    },
  },
}
