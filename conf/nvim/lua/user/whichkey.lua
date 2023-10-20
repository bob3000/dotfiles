local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local opts_no_prefix = vim.tbl_deep_extend("force", opts, {
  prefix = "",
})

local mappings_no_prefix = {
  ["<M-c>"] = { "<cmd>DapContinue<cr>", "Continue" },
  ["<M-h>"] = { "<cmd>DapStepOut<cr>", "Step Out" },
  ["<M-t>"] = { "<cmd>DapTerminate<cr>", "Terminate" },
  ["<M-j>"] = { "<cmd>DapStepOver<cr>", "Step Over" },
  ["<M-l>"] = { "<cmd>DapStepInto<cr>", "Step Into" },
  ["<M-r>"] = { "<cmd>DapToggleRepl<cr>", "Toggle Repl" },
  ["<M-b>"] = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
  ["<M-u>"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle DAP UI" },
}

local mappings = {
  [";"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["B"] = { "<cmd>let &background = ( &background == 'dark' ? 'light' : 'dark' )<cr>", "Background color" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{" ..
      "previewer = false, sort_mru = true, ignore_current_buffer = true})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["o"] = { "<cmd>:SymbolsOutline<cr>", "Outline" },
  ["W"] = { "<cmd>lua vim.lsp.buf.format{ async = false }; vim.api.nvim_command('write')<CR>", "Format and Save" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", "Find Text" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["M"] = { "<cmd>PeekOpen<cr>", "Markdown" },
  ["n"] = { "<cmd>Neogen<cr>", "Gen Comment" },
  ["U"] = { "<cmd>lua require('telescope').extensions.undo.undo()<cr>", "Undo tree" },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  s = {
    name = "Search",
    S = { "<cmd>lua require('spectre').open()<CR>", "Spectr replace" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    m = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media files" },
    n = { "<cmd>Telescope notify<cr>", "Notification history" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  t = {
    name = "Terminal",
    c = { "<cmd>lua _CONFIG_TOGGLE()<cr>", "Config" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    w = { "<cmd>lua _WIKI_TOGGLE()<cr>", "Wiki" },
  },
  x = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
    c = { "<cmd>GitConflictListQf<cr>", "Git Conflicts" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix List" },
    R = { "<cmd>TroubleToggle lsp_references<cr>", "Lsp References" },
    t = { "<cmd>TodoTrouble<cr>", "Todos" },
  },
  d = {
    name = "Debug",
    b = { "<cmd>DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
    B = { "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear Breakpoints" },
    c = { "<cmd>DapContinue<cr>", "Continue" },
    i = { "<cmd>DapStepInto<cr>", "Step Into" },
    o = { "<cmd>DapStepOver<cr>", "Step Over" },
    O = { "<cmd>DapStepOut<cr>", "Step Out" },
    r = { "<cmd>DapToggleRepl<cr>", "Toggle Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle DAP UI" },
    t = { "<cmd>DapTerminate<cr>", "Terminate" },
    v = { "<cmd>lua require'osv'.launch({port = 8086})<cr>", "nvim debug server" },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(mappings_no_prefix, opts_no_prefix)
