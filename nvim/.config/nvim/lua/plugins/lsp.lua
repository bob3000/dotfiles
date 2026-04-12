local icons = require 'config.icons'
local tools = require 'config.tools'
local diagnostic_format = function(diagnostic)
  local diagnostic_message = {
    [vim.diagnostic.severity.ERROR] = diagnostic.message,
    [vim.diagnostic.severity.WARN] = diagnostic.message,
    [vim.diagnostic.severity.INFO] = diagnostic.message,
    [vim.diagnostic.severity.HINT] = diagnostic.message,
  }
  return diagnostic_message[diagnostic.severity]
end

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
    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    config = function(ev)
      -- install tools
      local ensure_installed = tools.servers
      vim.list_extend(ensure_installed, tools.tools)
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (installs populated via mason-tool-installer)
        automatic_installation = false,
      }

      -- set up keymaps
      local wk = require 'which-key'
      wk.add {
        { 'grn', vim.lsp.buf.rename, desc = 'Rename' },
        { 'gra', vim.lsp.buf.code_action, desc = 'Code Actions' },
        { 'grh', '<cmd>LspClangdSwitchSourceHeader<cr>', desc = 'Switch header source' },
        -- keybindings implemented by snacks
        -- { 'grr', vim.lsp.buf.references, desc = 'References' }
        -- { 'gri', vim.lsp.buf.implementation, desc = 'Implementation' },
        -- { 'grt', vim.lsp.buf.type_definition, desc = 'Type Definition' },
        { 'gO', vim.lsp.buf.document_symbol, desc = 'Document Symbol' },
        { '<C-s>', vim.lsp.buf.signature_help, desc = 'Signature help', mode = { 'n', 'i' } },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
        callback = function(event)
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
          local bufnr = event.buf
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = bufnr,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = bufnr,
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

          -- toggle inlay hints automatically
          if client:supports_method 'textDocument/inlayHint' then
            local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })

            if vim.g.auto_inlay_hints then
              -- Initial inlay hint display.
              -- Idk why but without the delay inlay hints aren't displayed at the very start.
              vim.defer_fn(function()
                local mode = vim.api.nvim_get_mode().mode
                vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
              end, 500)
            end

            vim.api.nvim_create_autocmd('InsertEnter', {
              group = inlay_hints_group,
              desc = 'Enable inlay hints',
              buffer = bufnr,
              callback = function()
                if vim.g.auto_inlay_hints then
                  vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                end
              end,
            })

            vim.api.nvim_create_autocmd('InsertLeave', {
              group = inlay_hints_group,
              desc = 'Disable inlay hints',
              buffer = bufnr,
              callback = function()
                if vim.g.auto_inlay_hints then
                  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
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
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          },
        },
        underline = { severity = vim.diagnostic.severity.ERROR },
        -- virtual_lines = {
        --   current_line = true,
        --   format = diagnostic_format,
        -- },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = diagnostic_format,
        },
      }

      -- Set up LSP servers.
      vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
        once = true,
        callback = function()
          -- LSP servers and clients are able to communicate to each other what features they support.
          --  By default, Neovim doesn't support everything that is in the LSP specification.
          --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
          --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
          local capabilities = require('blink.cmp').get_lsp_capabilities(nil, true)
          vim.lsp.config('*', { capabilities = capabilities })

          for _, server_name in pairs(tools.servers) do
            vim.lsp.enable(server_name)
          end
        end,
      })
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
              require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets' } }
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
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },
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
      fuzzy = { implementation = 'prefer_rust_with_warning' },
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
