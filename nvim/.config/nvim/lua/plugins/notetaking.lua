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
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = false,
      },
    },
    ft = { 'markdown', 'norg', 'rmd', 'org', 'codecompanion' },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      Snacks.toggle({
        name = 'Render Markdown',
        get = function()
          return require('render-markdown.state').enabled
        end,
        set = function(enabled)
          local m = require 'render-markdown'
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map '<leader>um'

      -- disable rendering in insert mode
      vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
        callback = require('render-markdown').buf_disable,
      })

      -- enable rendering when leaving insert mode
      vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        callback = require('render-markdown').buf_enable,
      })
    end,
  },
}
