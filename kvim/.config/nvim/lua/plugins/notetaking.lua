return {
  {
    'jakewvincent/mkdnflow.nvim',
    ft = 'markdown',
    keys = {
      { '<leader>N', group = 'Note taking', icon = '󰺿' },
      { '<leader>Ni', '<cmd>e ~/Nextcloud/Synced/wiki/index.md<CR>', desc = 'Note index' },
      {
        '<leader>Ns',
        function()
          vim.fn.chdir '~/Nextcloud/Synced/wiki'
          require('fzf-lua').live_grep()
        end,
        desc = 'Search notes',
      },
    },
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
    end,
  },
}
