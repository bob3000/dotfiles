-- general
lvim.transparent_window = true
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "gruvbox"
vim.o.guifont = "Fira Code:h10"
vim.o.colorcolumn = "80,120"
vim.o.relativenumber = true

-- keymappings
lvim.leader = "space"
-- overwrite the key-mappings provided by LunarVim for any mode, or leave it empty to keep them
-- lvim.keys.normal_mode = {
--   Page down/up
--   {'[d', '<PageUp>'},
--   {']d', '<PageDown>'},
--
--   Navigate buffers
--   {'<Tab>', ':bnext<CR>'},
--   {'<S-Tab>', ':bprevious<CR>'},
-- }
-- if you just want to augment the existing ones then use the utility function
-- require("lv-utils").add_keymap_insert_mode({ silent = true }, {
-- { "<C-s>", ":w<cr>" },
-- { "<C-c>", "<ESC>" },
-- })
-- you can also use the native vim way directly
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- Additional Plugins
lvim.lsp.override = { "rust" }
local rust_tools_opts = {
	tools = { -- rust-tools options
		autoSetHints = true,
		hover_with_actions = true,
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {},
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
		},
	},
}

lvim.plugins = {
  -- laguages
	{ "jvirtanen/vim-hcl" },
  { "cespare/vim-toml" },
  { "chr4/nginx.vim" },
	{ "lervag/vimtex" },
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup(rust_tools_opts)
		end,
    ft = { "rust", "rs" }
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	},
  -- colors / display
	{ "rktjmp/lush.nvim" },
	{ "sainnhe/sonokai" },
	{ "npxbr/gruvbox.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	-- {"lukas-reineke/indent-blankline.nvim"},
  -- navigation
	{ "simrat39/symbols-outline.nvim" },
	{ "folke/trouble.nvim" },
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
  -- editing
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "andymass/vim-matchup" },
  -- search / replace
	{
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},
  -- debugging
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
    ft = { "python", "rust" },
  },
	{
		"nvim-telescope/telescope-dap.nvim",
		config = function()
      require('telescope').load_extension('dap')
		end,
	},
  -- language server
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	config = function()
	-- 		require("lsp_signature").on_attach()
	-- 	end,
	-- 	event = "InsertEnter",
	-- },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
	{
		"InsertEnter",
		"*",
		"if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif",
	},
	{ "InsertLeave", "*", 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif' },
	{ "InsertEnter", "*", "if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif" },
	{ "InsertLeave", "*", 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif' },
}

-- Additional Leader bindings for WhichKey
lvim.builtin.which_key.mappings["t"] = {
	name = "Extra Windows",
	d = { "<cmd>TroubleToggle<CR>", "Togggle Trouble" },
	o = { "<cmd>SymbolsOutline<CR>", "Togggle Symbols Outline" },
	m = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown Browser" },
	t = { "<cmd>TodoTrouble<CR>", "Togggle Todos" },
	D = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle DAP UI" },
}

lvim.builtin.which_key.mappings["R"] = {
	name = "Rust Tools",
	b = { "<cmd>lua require('core.terminal')._exec_toggle('cargo build;read')<CR>", "Cargo build" },
	r = { "<cmd>lua require('core.terminal')._exec_toggle('cargo run;read')<CR>", "Cargo run" },
	t = { "<cmd>lua require('core.terminal')._exec_toggle('cargo test;read')<CR>", "Cargo test" },
	c = { "<cmd>lua require('core.terminal')._exec_toggle('cargo check;read')<CR>", "Cargo check" },
	m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
	H = { "<cmd>RustToggleInlayHints<CR>", "Inlay Hints" },
	R = { "<cmd>RustRunnables<CR>", "Runnables" },
	h = { "<cmd>RustHoverActions<CR>", "Hover Actions" },
	d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
}

lvim.builtin.which_key.mappings["r"] = {
	name = "Replace",
	r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
	w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
	f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}

-- DAP
lvim.builtin.dap.on_config_done = function(dap)
  -- Rust
  -- install lldb-vscode
  dap.adapters.rust = {
    type = "executable",
    attach = {
      pidProperty = "pid",
      pidSelect = "ask",
    },
    command = "lldb-vscode", -- my binary was called 'lldb-vscode-11'
    env = {
      LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
    },
    name = "lldb",
  }
  dap.configurations.rust = {
    {
      type = "rust",
      name = "Debug",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }
end
