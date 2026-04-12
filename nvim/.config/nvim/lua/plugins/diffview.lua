local icons = require 'config.icons'

-- Diffs for git revisions.
return {
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gF', '<cmd>DiffviewFileHistory<cr>', desc = 'File history' },
      { '<leader>gD', '<cmd>DiffviewOpen<cr>', desc = 'Diff view' },
    },
    opts = function()
      local actions = require 'diffview.actions'

      require('diffview.ui.panel').Panel.default_config_float.border = 'rounded'

      return {
        default_args = { DiffviewFileHistory = { '%' } },
        icons = {
          folder_closed = icons.folder.closed,
          folder_open = icons.folder.open,
        },
        signs = {
          fold_closed = icons.arrows.right,
          fold_open = icons.arrows.down,
          done = '',
        },
      }
    end,
  },
}
