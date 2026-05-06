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
          local quicker = require('quicker')
          local win = vim.api.nvim_get_current_win()
          if quicker.is_open(win) then
            quicker.close({ loclist = true })
          else
            vim.diagnostic.setloclist({ open = false })
            quicker.open({ loclist = true, focus = false })
          end
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
            vim.diagnostic.setqflist({ open = false })
            quicker.open({ focus = false })
          end
        end,
        desc = 'Toggle diagnostics',
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('DiagnosticChanged', {
        callback = function()
          local quicker = require('quicker')
          local win = vim.api.nvim_get_current_win()
          if quicker.is_open(win) then
            vim.diagnostic.setloclist()
            quicker.refresh(win)
          elseif quicker.is_open() then
            vim.diagnostic.setqflist()
            quicker.refresh()
          end
        end,
      })
    end,
  },
}
