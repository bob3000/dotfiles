return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters_by_ft = {
        css = { 'prettier' },
        graphql = { 'prettier' },
        handlebars = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        scss = { 'prettier' },
        yaml = { 'prettier' },

        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
