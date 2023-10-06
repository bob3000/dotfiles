local status_ok, rust_tools = pcall(require, "rust-tools")
if not status_ok then
  return
end

local dbg_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/")
local codelldb_path = dbg_path .. "adapter/codelldb"
local liblldb_path = dbg_path .. "lldb/lib/liblldb"
local this_os = vim.loop.os_uname().sysname;

-- The path in windows is different
if this_os:find "Windows" then
  codelldb_path = dbg_path .. "adapter\\codelldb.exe"
  liblldb_path = dbg_path .. "lldb\\bin\\liblldb.dll"
else
  -- The liblldb extension is .so for linux and .dylib for macOS
  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local term_ok, term = pcall(require, "toggleterm.terminal")
local Terminal = nil
if term_ok then
  Terminal = term.Terminal
  local cargo_build = Terminal:new { cmd = "cargo build; read", hidden = true }
  function _CARGO_BUILD()
    cargo_build:toggle()
  end
  local cargo_run = Terminal:new { cmd = "cargo run; read", hidden = true }
  function _CARGO_RUN()
    cargo_run:toggle()
  end
  local cargo_test = Terminal:new { cmd = "cargo test -- --nocapture; read", hidden = true }
  function _CARGO_TEST()
    cargo_test:toggle()
  end
  local cargo_check = Terminal:new { cmd = "cargo check; read", hidden = true }
  function _CARGO_CHECK()
    cargo_check:toggle()
  end
  local cargo_clippy = Terminal:new { cmd = "cargo clippy; read", hidden = true }
  function _CARGO_CLIPPY()
    cargo_clippy:toggle()
  end
end

local mappings = {
  R = {
    name = "Rust Tools",
    b = { "<cmd>lua _CARGO_BUILD()<CR>", "Cargo build" },
    r = { "<cmd>lua _CARGO_RUN()<CR>", "Cargo run" },
    t = { "<cmd>lua _CARGO_TEST()<CR>", "Cargo test" },
    c = { "<cmd>lua _CARGO_CHECK()<CR>", "Cargo check" },
    C = { "<cmd>lua _CARGO_CLIPPY()<CR>", "Cargo clippy" },
    m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
    H = { "<cmd>RustToggleInlayHints<CR>", "Inlay Hints" },
    R = { "<cmd>RustRunnables<CR>", "Runnables" },
    h = { "<cmd>RustHoverActions<CR>", "Hover Actions" },
    d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
  },
}

rust_tools.setup {
  tools = {
    -- executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "<-",
      other_hints_prefix = "=>",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    hover_actions = {
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },
      auto_focus = true,
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  },
  server = {
    on_attach = function(_, bufnr)
      local which_key_ok, which_key = pcall(require, "which-key")
      if which_key_ok then
        opts.buffer = bufnr
        which_key.register(mappings, opts)
      end
    end,
  },
}
