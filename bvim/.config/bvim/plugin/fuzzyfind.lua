return {
  vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
  }),
  vim.schedule(function()
    local actions = require("fzf-lua.actions")
    local icons = require("config.icons")

    return {
      { "border-fused", "hide" },
      -- Make stuff better combine with the editor.
      fzf_colors = {
        bg = { "bg", "Normal" },
        gutter = { "bg", "Normal" },
        info = { "fg", "Conditional" },
        scrollbar = { "bg", "Normal" },
        separator = { "fg", "Comment" },
      },
      fzf_opts = {
        ["--info"] = "default",
        ["--layout"] = "reverse-list",
      },
      keymap = {
        builtin = {
          ["<C-/>"] = "toggle-help",
          ["<C-a>"] = "toggle-fullscreen",
          ["<C-i>"] = "toggle-preview",
        },
        fzf = {
          ["alt-s"] = "toggle",
          ["alt-a"] = "toggle-all",
          ["ctrl-i"] = "toggle-preview",
        },
      },
      winopts = {
        height = 0.7,
        width = 0.55,
        preview = {
          scrollbar = false,
          layout = "vertical",
          vertical = "up:40%",
        },
      },
      defaults = { git_icons = false },
      previewers = {
        codeaction = { toggle_behavior = "extend" },
      },
      -- Configuration for specific commands.
      files = {
        winopts = {
          preview = { hidden = true },
        },
      },
      grep = {
        -- Search in hidden files by default.
        hidden = true,
        header_prefix = icons.misc.search .. " ",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -g \"!.git\" -e",
        rg_glob_fn = function(query, opts)
          local regex, flags = query:match(string.format("^(.*)%s(.*)$", opts.glob_separator))
          -- Return the original query if there's no separator.
          return (regex or query), flags
        end,
      },
      helptags = {
        actions = {
          -- Open help pages in a vertical split.
          ["enter"] = actions.help_vert,
        },
      },
      lsp = {
        symbols = {
          symbol_icons = icons.symbol_kinds,
        },
        code_actions = {
          winopts = {
            width = 70,
            height = 20,
            relative = "cursor",
            preview = {
              hidden = true,
              vertical = "down:50%",
            },
          },
        },
      },
      diagnostics = {
        -- Remove the dashed line between diagnostic items.
        multiline = 1,
        diag_icons = {
          icons.diagnostics.ERROR,
          icons.diagnostics.WARN,
          icons.diagnostics.INFO,
          icons.diagnostics.HINT,
        },
        actions = {
          ["ctrl-e"] = {
            fn = function(_, opts)
              -- If not filtering by severity, show all diagnostics.
              if opts.severity_only then
                opts.severity_only = nil
              else
                -- Else only show errors.
                opts.severity_only = vim.diagnostic.severity.ERROR
              end
              require("fzf-lua").resume(opts)
            end,
            noclose = true,
            desc = "toggle-all-only-errors",
            header = function(opts)
              return opts.severity_only and "show all" or "show only errors"
            end,
          },
        },
      },
      oldfiles = {
        include_current_session = true,
        winopts = {
          preview = { hidden = true },
        },
      },
    }
  end),
  vim.keymap.set({ "n", "x" }, "<leader>fb", function()
    local opts = {
      winopts = {
        height = 0.6,
        width = 0.5,
        preview = { vertical = "up:70%" },
        -- Disable Treesitter highlighting for the matches.
        treesitter = {
          enabled = false,
          fzf_colors = { ["fg"] = { "fg", "CursorLine" }, ["bg"] = { "bg", "Normal" } },
        },
      },
      fzf_opts = {
        ["--layout"] = "reverse",
      },
    }

    -- Use grep when in normal mode and blines in visual mode since the former doesn't support
    -- searching inside visual selections.
    -- See https://github.com/ibhagwan/fzf-lua/issues/2051
    local mode = vim.api.nvim_get_mode().mode
    if vim.startswith(mode, "n") then
      require("fzf-lua").lgrep_curbuf(opts)
    else
      require("fzf-lua").blines(opts)
    end
  end, { desc = "Search current buffer" }),

  vim.keymap.set({ "n", "x" }, "<leader>fB", "<cmd>FzfLua buffers<cr>", { desc = "Buffers" }),
  vim.keymap.set({ "n", "x" }, "<leader>fc", "<cmd>FzfLua highlights<cr>", { desc = "Highlights" }),
  vim.keymap.set(
    { "n", "x" },
    "<leader>fd",
    "<cmd>FzfLua lsp_document_diagnostics<cr>",
    { desc = "Document diagnostics" }
  ),
  vim.keymap.set({ "n", "x" }, "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" }),
  vim.keymap.set({ "n", "x" }, "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "Find keymaps" }),
  vim.keymap.set({ "n", "x" }, "<leader>/", "<cmd>FzfLua grep_visual<cr>", { desc = "Grep" }),
  vim.keymap.set({ "n", "x" }, "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help" }),
  vim.keymap.set({ "n", "x" }, "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recently opened files" }),
  vim.keymap.set({ "n", "x" }, "<leader>f<", "<cmd>FzfLua resume<cr>", { desc = "Resume last fzf command" }),
  vim.keymap.set({ "n", "x" }, "z=", "<cmd>FzfLua spell_suggest<cr>", { desc = "Spelling suggestions" }),
  vim.keymap.set({ "i" }, "<C-x><C-f>", function()
    require("fzf-lua").complete_path({
      winopts = {
        height = 0.4,
        width = 0.5,
        relative = "cursor",
      },
    })
  end, { desc = "Fuzzy complete path" }),
}
