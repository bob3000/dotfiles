return {
  { -- Autoformat
    'stevearc/conform.nvim',
    version = '*',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters = {
        ['markdown-toc'] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find('<!%-%- toc %-%->') then
                return true
              end
            end
          end,
        },
      },
      formatters_by_ft = {
        css = { 'biome' },
        fish = { 'fish_indent' },
        graphql = { 'biome' },
        handlebars = { 'biome' },
        hcl = { 'hcl' },
        html = { 'prettier' },
        javascript = { 'biome' },
        javascriptreact = { 'biome' },
        json = { 'biome' },
        jsonc = { 'biome' },
        lua = { 'stylua' },
        markdown = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
        python = { 'ruff_format', 'ruff_organize_imports' },
        scss = { 'biome' },
        yaml = { 'prettier' },
        typescript = { 'biome' },
        typescriptreact = { 'biome' },
      },
    },
  },
}
