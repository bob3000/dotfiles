local icons = require 'config.icons'
return {
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'b0o/schemastore.nvim',

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        bashls = {},
        clangd = {},
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
        neocmake = {},
        ruff = {},
        rust_analyzer = {
          {
            completion = {
              capable = {
                snippets = 'add_parenthesis',
              },
            },
          },
        },
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
                  'FzfLua',
                  'MiniBufremove',
                  'MiniNotify',
                  'Snacks',
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
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'bash-debug-adapter',
        'biome',
        'cmakelang',
        'cmakelint',
        'codelldb',
        'debugpy',
        'delve',
        'firefox-debug-adapter',
        'gofumpt',
        'goimports',
        'hadolint', -- mason version seems to be broken
        'js-debug-adapter',
        'markdownlint',
        'markdown-toc',
        'prettier',
        'shellcheck',
        'shfmt',
        'stylua',
        'taplo',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (installs populated via mason-tool-installer)
        automatic_installation = false,
      }

      for server_name, settings in pairs(servers) do
        vim.lsp.enable(server_name)
        settings.capabilities = vim.tbl_deep_extend('force', {}, capabilities, settings.capabilities or {})
        vim.lsp.config(server_name, settings)
      end
    end,
  },
  { -- Autocompletion
    'saghen/blink.cmp',
    build = 'cargo build --release',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1000,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = {
          enabled = true,
          auto_show = true,
          auto_show_delay_ms = 100,
        },
        ghost_text = {
          show_with_menu = true,
          show_without_menu = true,
          show_with_selection = true,
          show_without_selection = true,
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },
      -- fuzzy = { implementation = 'prefer_rust_with_warning' },
      -- prebuilt_binaries = {
      --   -- Whether or not to automatically download a prebuilt binary from github. If this is set to `false`,
      --   -- you will need to manually build the fuzzy binary dependencies by running `cargo build --release`
      --   -- Disabled by default when `fuzzy.implementation = 'lua'`
      --   download = false,
      -- },
      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
}
