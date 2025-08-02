return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          mason = false,
        },
        yamlls = {
          mason = false,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ansible-language-server",
        "ansible-lint",
        -- "autotools-language-server",
        "basedpyright",
        "bash-debug-adapter",
        "bash-language-server",
        -- "black",
        -- "css-lsp",
        "clangd",
        "codelldb",
        -- "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gofumpt",
        "goimports",
        "gopls",
        "hadolint",
        -- "html-lsp",
        -- "htmx-lsp",
        "helm-ls",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        -- "marksman", -- doesn't terminate correctly / uses 100% CPU
        "prettier",
        "ruff",
        -- "ruff-lsp",
        -- "rust-analyzer", -- installed by rustaceanvim
        "shfmt",
        "stylua",
        "taplo",
        "templ",
        "terraform-ls",
        "vtsls",
        -- "yaml-language-server", -- slow and shows false errors
        "zls",
      })

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if not opts.ensure_installed or #opts.ensure_installed == 0 then
          print("ERROR: ensure_installed is empty")
          return
        end
        local registry = require("mason-registry")
        local installed_packages = {}
        for _, pkg in ipairs(registry.get_installed_packages()) do
          vim.list_extend(installed_packages, { pkg.name })
        end
        local to_install = {}
        for _, pkg_name in ipairs(opts.ensure_installed) do
          if not vim.list_contains(installed_packages, pkg_name) then
            vim.list_extend(to_install, { pkg_name })
            print(pkg_name)
          end
        end
        vim.cmd("MasonInstall " .. table.concat(to_install, " "))
      end, {})
    end,
  },
}
