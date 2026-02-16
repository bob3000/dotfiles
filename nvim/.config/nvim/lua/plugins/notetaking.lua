return {
  {
    'jakewvincent/mkdnflow.nvim',
    ft = 'markdown',
    keys = {
      { '<leader>N', group = 'Note taking', icon = '󰺿' },
      { '<leader>Ni', '<cmd>e ~/Nextcloud/Synced/wiki/index.md<CR>', desc = 'Notes index' },
      { '<leader>Nl', '<cmd>e ~/Nextcloud/Synced/wiki/2026-01-05_2026.md<CR>', desc = 'Notes' },
      {
        '<leader>Ns',
        function()
          Snacks.picker.files { dirs = { '~/Nextcloud/Synced/wiki' } }
        end,
        desc = 'Search notes',
      },
    },
    opts = {
      modules = {
        yaml = true,
        completion = false,
      },
      links = {
        conceal = true,
        transform_implicit = true,
      },
      new_file_template = {
        use_template = true,
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
  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = function()
      require('lazy').load { plugins = { 'markdown-preview.nvim' } }
      vim.fn['mkdp#util#install']()
    end,
    keys = {
      {
        '<leader>cp',
        ft = 'markdown',
        '<cmd>MarkdownPreviewToggle<cr>',
        desc = 'Markdown Preview',
      },
    },
    config = function()
      vim.cmd [[do FileType]]
    end,
  },
}
