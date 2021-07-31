-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

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
		server = {
			cmd = { DATA_PATH .. "/lspinstall/rust/rust-analyzer" },
			on_attach = require("lsp").common_on_attach,
			capabilities = require("lsp").common_capabilities,
		}, -- rust-analyser options
	},
}

lvim.plugins = {
	{ "lervag/vimtex", opt = true },
	{ "npxbr/glow.nvim", opt = true },
	{ "rktjmp/lush.nvim" },
	{
		"simrat39/rust-tools.nvim",
		opt = true,
		config = function()
			require("rust-tools").setup(rust_tools_opts)
		end,
	},
	{ "simrat39/symbols-outline.nvim" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "jvirtanen/vim-hcl", opt = true },
	{ "sainnhe/sonokai" },
	{ "npxbr/gruvbox.nvim" },
	{ "folke/trouble.nvim" },
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	-- {"lukas-reineke/indent-blankline.nvim"},
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

	-- { "Filetype", "rust", "nnoremap <leader>lm <Cmd>RustExpandMacro<CR>" },
	-- { "Filetype", "rust", "nnoremap <leader>lH <Cmd>RustToggleInlayHints<CR>" },
	-- { "Filetype", "rust", "nnoremap <leader>le <Cmd>RustRunnables<CR>" },
	-- { "Filetype", "rust", "nnoremap <leader>lh <Cmd>RustHoverActions<CR>" },
}

-- Additional Leader bindings for WhichKey
lvim.builtin.which_key.mappings["x"] = {
	name = "Custom Commands",
	d = { "<cmd>TroubleToggle<CR>", "Togggle Trouble" },
	o = { "<cmd>SymbolsOutline<CR>", "Togggle Symbols Outline" },
	p = { "<cmd>Glow<CR>", "Preview Markdown" },
	t = { "<cmd>TodoTrouble<CR>", "Togggle Todos" },
}

lvim.builtin.which_key.mappings["r"] = {
	name = "Rust Tools",
	m = { "<cmd>RustExpandMacro<CR>", "Expand Macro" },
	H = { "<cmd>RustToggleInlayHints<CR>", "Inlay Hints" },
	r = { "<cmd>RustRunnables<CR>", "Runnables" },
	h = { "<cmd>RustHoverActions<CR>", "Hover Actions" },
}
