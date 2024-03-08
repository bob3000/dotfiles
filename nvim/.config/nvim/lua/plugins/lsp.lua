return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "black",
        "clangd",
        "codelldb",
        "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gofumpt",
        "goimports",
        "gopls",
        "hadolint",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettier",
        "pyright",
        "ruff-lsp",
        "rust-analyzer",
        "shfmt",
        "stylua",
        "taplo",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
        "zls",
      })

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})
    end,
  },
}
