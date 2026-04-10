vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim", name = "conform", version = vim.version.range("*") },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  once = true,
  callback = function()
    require("conform").setup({
      notify_on_error = false,
      format_on_save = false,
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
      },
      formatters_by_ft = {
        css = { "biome" },
        fish = { "fish_indent" },
        graphql = { "biome" },
        handlebars = { "biome" },
        html = { "prettier" },
        json = { "biome" },
        jsonc = { "biome" },
        lua = { "stylua" },
        markdown = { "biome", "markdown-toc" },
        python = { "ruff_format", "ruff_organize_imports" },
        scss = { "biome" },
        yaml = { "biome" },

        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    })
  end,
  vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end, { desc = "Format buffer" }),
})
