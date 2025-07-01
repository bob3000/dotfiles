local wk = require 'which-key'

return {
  {
    'jakewvincent/mkdnflow.nvim',
    ft = 'markdown',
    keys = function()
      wk.add {
        { '<leader>N', group = 'Note taking', icon = '📓' },
        { '<leader>Ni', '<cmd>e ~/Nextcloud/Synced/wiki/index.md<CR>', desc = 'Note index' },
        {
          '<leader>Ns',
          function()
            vim.fn.chdir '~/Nextcloud/Synced/wiki'
            require('fzf-lua').live_grep()
          end,
          desc = 'Search notes',
        },
      }
    end,
    opts = {
      modules = {
        yaml = true,
        cmp = false,
      },
      links = {
        conceal = true,
        transform_implicit = true,
      },
      new_file_template = {
        use_template = true,
        placeholders = {
          before = {
            title = 'link_title',
            date = 'os_date',
          },
          after = {},
        },
        template = '# {{ title }} - {{ date }}\n',
      },
      mappings = {
        MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>Np' }, -- see MkdnEnter
        MkdnUpdateNumbering = { 'n', '<leader>Nn' },
        MkdnTableNewRowBelow = { 'n', '<leader>Nr' },
        MkdnTableNewRowAbove = { 'n', '<leader>NR' },
        MkdnTableNewColAfter = { 'n', '<leader>Nc' },
        MkdnTableNewColBefore = { 'n', '<leader>NC' },
        MkdnFoldSection = { 'n', '<leader>Nf' },
        MkdnUnfoldSection = { 'n', '<leader>NF' },
      },
    },
  },
}
