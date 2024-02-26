return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "fish",
        "groovy",
        "make",
        "nix",
        "ruby",
        "sql",
        "xml",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    enabled = false,
    opts = {
      tools = {
        -- use native inlay hints instead
        inlay_hints = { auto = false },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find("Windows") then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has("mac") == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb_path)
        require("dap.ext.vscode").load_launchjs(nil, { codelldb = {'rust'} })
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd([[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]])
          end,
        },
        server = {
          on_attach = function(client, bufnr)
            -- register which-key mappings
            local wk = require("which-key")
            wk.register({
              ["<leader>cR"] = {
                function()
                  vim.cmd.RustLsp("codeAction")
                end,
                "Code Action",
              },
              ["<leader>dr"] = {
                function()
                  vim.cmd.RustLsp("debuggables")
                end,
                "Rust debuggables",
              },
            }, { mode = "n", buffer = bufnr })
          end,
          settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
            },
          },
        },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
  },
  -- Correctly setup lspconfig for Rust 🚀
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function(_, opts)
          return true
        end,
      },
    },
  },
}
