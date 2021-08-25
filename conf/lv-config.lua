local components = require("core.lualine.components")

-- general
lvim.debug = false
lvim.transparent_window = true
lvim.format_on_save = true
lvim.lint_on_save = true
vim.g.gruvbox_material_palette = "original"
vim.g.sonokai_style = "maia"
lvim.colorscheme = "gruvbox-material"
vim.o.guifont = "Fira Code:h10"
vim.o.colorcolumn = "80,120"
vim.o.relativenumber = true
vim.o.spell = true
vim.o.inccommand = "split"
-- vim.o.listchars = "tab:»·,eol:↲,nbsp:␣,extends:…,space:␣,precedes:<,extends:>,trail:·"
vim.o.listchars = "tab:»·,extends:…,precedes:<,extends:>,trail:·"
vim.o.list = true

lvim.leader = "space"
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "gitui", "gi", "GitUI" }

-- status line
lvim.builtin.lualine.options.theme = "gruvbox"
lvim.builtin.lualine.sections.lualine_x = {
	"string.format('col:%3d', vim.api.nvim_win_get_cursor(0)[2])",
	components.diagnostics,
	components.treesitter,
	components.lsp,
	components.filetype,
}
lvim.builtin.lualine.sections.lualine_z = {
	components.scrollbar,
	"(vim.fn.mode() == 'v' or vim.fn.mode() == 'V') and string.format('%d words', vim.fn.wordcount()['visual_words'])",
}

-- language server
lvim.lang.lua.formatters = { { exe = "stylua", args = {} } }
lvim.lang.tailwindcss = {
	active = true,
	lsp = {
		provider = "tailwindcss",
		setup = {
			cmd = {
				DATA_PATH .. "/lspinstall/tailwindcss/tailwindcss-intellisense.sh",
				"--stdio",
			},
			filetypes = {
				"html",
				"css",
				"scss",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"svelte",
			},
		},
	},
}

if lvim.lang.tailwindcss.active then
	require("lsp").setup("tailwindcss")
end

lvim.lsp.override = { "rust" }

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

lvim.builtin.which_key.mappings["S"] = {
	name = "Session",
	o = { "<cmd>lua require('persistence').load()<cr>", "Open Session" },
	l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Last Session" },
	d = { "<cmd>lua require('persistence').stop()<cr>", "Disable Saving" },
}

lvim.builtin.which_key.mappings["lt"] = {
	"<cmd>FixWhitespace<cr>",
	"Trim trailing spaces",
}

lvim.builtin.which_key.mappings["sP"] = {
	"<cmd>Telescope projects<cr>",
	"Projects",
}

lvim.builtin.which_key.mappings["R"] = {
	name = "Rust Tools",
	b = { "<cmd>lua require('core.terminal')._exec_toggle('cargo build;read')<CR>", "Cargo build" },
	r = { "<cmd>lua require('core.terminal')._exec_toggle('cargo run;read')<CR>", "Cargo run" },
	t = { "<cmd>lua require('core.terminal')._exec_toggle('cargo test -- --nocapture;read')<CR>", "Cargo test" },
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

-- Additional Plugins
lvim.plugins = {
	-- laguages
	{ "jvirtanen/vim-hcl" },
	{ "cespare/vim-toml" },
	{ "chr4/nginx.vim" },
	{ "lervag/vimtex" },
	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local opts = {
				tools = { -- rust-tools options
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
					inlay_hints = {
						show_parameter_hints = true,
						parameter_hints_prefix = "<-",
						other_hints_prefix = "=>",
						max_len_align = false,
						max_len_align_padding = 1,
						right_align = false,
						right_align_padding = 7,
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
					},
				},
				server = {
					cmd = { DATA_PATH .. "/lspinstall/rust/rust-analyzer" },
					on_attach = require("lsp").common_on_attach,
				},
			}
			require("rust-tools").setup(opts)
		end,
		ft = { "rust", "rs" },
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	},
	-- colors / display
	{ "rktjmp/lush.nvim" },
	{ "sainnhe/everforest" },
	{ "sainnhe/sonokai" },
	{ "sainnhe/edge" },
	{ "sainnhe/gruvbox-material" },
	-- { "ajmwagar/vim-deus" },
	{ "christianchiarulli/nvcode-color-schemes.vim" },
	-- { "folke/tokyonight.nvim" },
	-- { "npxbr/gruvbox.nvim" },
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
	{ "bronson/vim-trailing-whitespace" },
	{ "andymass/vim-matchup" },
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = function()
			require("nvim-treesitter.configs").setup({
				context_commentstring = {
					enable = true,
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
		event = "BufWinEnter",
	},
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
			require("telescope").load_extension("dap")
		end,
	},
	-- session
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/sessions/"), -- directory where session files are saved
				options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			})
		end,
	},
	-- language server
	-- {
	-- 	"tzachar/compe-tabnine",
	-- 	run = "./install.sh",
	-- 	requires = "hrsh7th/nvim-compe",
	-- 	-- event = "InsertEnter",
	-- },
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	config = function()
	-- 		require("lsp_signature").on_attach()
	-- 	end,
	-- 	event = "InsertEnter",
	-- },
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
				return vim.fn.input("Path to executable: ", CACHE_PATH .. "/target/debug/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			runInTerminal = false,
		},
	}
end
