return {
  -- Enable the following language servers
  --
  --  Add any additional override configuration in the following tables. Available keys are:
  --  - cmd (table): Override the default command used to start the server
  --  - filetypes (table): Override the default list of associated filetypes for the server
  --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
  --  - settings (table): Override the default settings passed when initializing the server.
  --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
  servers = {
    bashls = {},
    -- clangd = {},
    gopls = {},
    basedpyright = {},
    dockerls = {},
    docker_compose_language_service = {},
    helm_ls = {},
    biome = {},
    jsonls = {
      -- lazy-load schemastore when needed
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },
    -- neocmake = {},
    ruff = {},
    -- rust_analyzer = {
    --   {
    --     completion = {
    --       capable = {
    --         snippets = 'add_parenthesis',
    --       },
    --     },
    --   },
    -- },
    sqruff = {},
    terraformls = {},
    tflint = {
      filetypes = {
        'terraform',
        'terraform-vars',
      },
    },
    vtsls = {},
    lua_ls = {
      -- cmd = { ... },
      -- filetypes = { ... },
      -- capabilities = {},
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {
              'Snacks',
              'FzfLua',
              'vim',
            },
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
    yamlls = {
      -- make sure mason installs the server
      servers = {
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = '',
              },
            },
          },
        },
      },
    },
    taplo = {},
  },

  -- list will be merged with the language servers listed above
  tools = {
    -- 'bash-debug-adapter',
    'biome',
    -- 'cmakelang',
    -- 'cmakelint',
    -- 'codelldb',
    'debugpy',
    'delve',
    'firefox-debug-adapter',
    'gofumpt',
    'goimports',
    'hadolint',
    'js-debug-adapter',
    'markdownlint',
    'markdown-toc',
    'prettier',
    'shellcheck',
    'shfmt',
    'stylua',
  },
}
