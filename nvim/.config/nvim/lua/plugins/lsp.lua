return {
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
        "helm-ls",
        "js-debug-adapter",
        "json-lsp",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettier",
        "ruff-lsp",
        -- "rust-analyzer",
        "shfmt",
        "stylua",
        "taplo",
        "terraform-ls",
        -- "typescript-language-server", -- replaced by vtsls
        "vtsls",
        "yaml-language-server",
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
