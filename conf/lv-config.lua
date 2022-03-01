-- globals
local components = require("lvim.core.lualine.components")

-- general
lvim.log.level = "warn"
-- breaks light themes
-- lvim.transparent_window = true
lvim.format_on_save = true
lvim.lint_on_save = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.gruvbox_material_palette = "original"
vim.g.sonokai_style = "maia"
vim.o.autowrite = true
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "catppuccino"
-- lvim.builtin.lualine.options.theme = "catppuccino"
-- lvim.colorscheme = "neon_latte"
-- lvim.colorscheme = "github_light"
-- lvim.builtin.lualine.options.theme = "ayu_light"
lvim.colorscheme = "gruvbox-material"
lvim.builtin.lualine.options.theme = "gruvbox"

vim.o.timeoutlen = 150
vim.o.guifont = "Fira Code:h10"
vim.o.colorcolumn = "80,120"
vim.o.relativenumber = true
vim.o.spelllang = "en_us,de_de"
vim.o.spellfile = "~/.config/lvim/spell/en.utf-8.add,~/.config/lvim/spell/de.utf-8.add"
vim.o.spell = true
vim.o.inccommand = "split"
-- vim.o.listchars = "tab:»·,eol:↲,nbsp:␣,extends:…,space:␣,precedes:<,extends:>,trail:·"
vim.o.listchars = "tab:»·,extends:…,precedes:<,extends:>,trail:·"
vim.o.list = true
vim.g.extra_whitespace_ignored_filetypes = { "dashboard", "quickfix", "TelescopePrompt" }
vim.g.vim_markdown_folding_disabled = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.builtin.autopairs.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs + 1] = { "gitui", "gi", "GitUI" }
lvim.builtin.notify.active = true

-- keymappings
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"

-- status line
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.bufferline.options.separator_style = "slant"
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

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"cmake",
	"comment",
	"css",
	"dockerfile",
	"dot",
	"go",
	"gomod",
	"graphql",
	"hcl",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"latex",
	"lua",
	"php",
	"python",
	"regex",
	"rust",
	"scss",
	"svelte",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"yaml",
	"zig",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ exe = "eslint" },
	{ exe = "flake8" },
	{ exe = "luacheck", args = { "--globals", "lvim" } },
	{
		exe = "shellcheck",
		args = { "--severity", "warning" },
	},
	{
		exe = "codespell",
		-- filetypes = { "typescript", "typescriptreact", "rust", "c", "python" },
	},
})

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "black" },
	{ exe = "shfmt", args = { "-i", "2", "-bn", "-sr", "-ci" } },
	{ exe = "stylua" },
	{
		exe = "prettier",
		filetypes = { "javascript", "typescript", "typescriptreact", "json" },
	},
})

lvim.lsp.override = vim.tbl_filter(function(it)
	return it ~= "tailwindcss" and it ~= "graphql" and it ~= "zeta_note" and it ~= "tflint" and it ~= "ansiblels"
end, lvim.lsp.override)
lvim.lsp.override = vim.list_extend(lvim.lsp.override, { "rust_analyzer" })

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
	{ "BufRead,BufNewFile", "*.nomad", "set filetype=hcl" },
	{ "BufRead,BufNewFile", "*.tsx", 'lua require("lvim.lsp.manager").setup("tailwindcss")' },
	{ "FileType", "zig,zir", "set shiftwidth=4" },
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

lvim.builtin.which_key.mappings["s/"] = {
	"<cmd>Telescope search_history<cr>",
	"Search History",
}

lvim.builtin.which_key.mappings["s:"] = {
	"<cmd>Telescope command_history<cr>",
	"Command History",
}

lvim.builtin.which_key.mappings["U"] = {
	name = "Rust Tools",
	b = { "<cmd>lua require('lvim.core.terminal')._exec_toggle('cargo build;read')<CR>", "Cargo build" },
	r = { "<cmd>lua require('lvim.core.terminal')._exec_toggle('cargo run;read')<CR>", "Cargo run" },
	t = { "<cmd>lua require('lvim.core.terminal')._exec_toggle('cargo test -- --nocapture;read')<CR>", "Cargo test" },
	c = { "<cmd>lua require('lvim.core.terminal')._exec_toggle('cargo check;read')<CR>", "Cargo check" },
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
	-- languages
	{ "chr4/nginx.vim" },
	-- { "lervag/vimtex" },
	{ "Glench/Vim-Jinja2-Syntax" },
	-- {
	-- 	"lewis6991/spellsitter.nvim",
	-- 	config = function()
	-- 		require("spellsitter").setup()
	-- 	end,
	-- },
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local lsp_installer_servers = require("nvim-lsp-installer.servers")
			local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
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
					cmd_env = requested_server._default_options.cmd_env,
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
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
	{ "godlygeek/tabular" },
	{ "plasticboy/vim-markdown" },
	-- colors / display
	{ "rktjmp/lush.nvim" },
	-- { "sainnhe/everforest" },
	-- { "sainnhe/sonokai" },
	-- { "sainnhe/edge" },
	-- { "projekt0n/github-nvim-theme" },
	{
		"olimorris/onedarkpro.nvim",
		config = function()
			require("onedarkpro").load()
		end,
	},
	{ "sainnhe/gruvbox-material" },
	-- { "catppuccin/nvim" },
	-- { "ajmwagar/vim-deus" },
	-- { "christianchiarulli/nvcode-color-schemes.vim" },
	-- { "folke/tokyonight.nvim" },
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
	-- completion
	{ "hrsh7th/cmp-emoji" },
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup()
		end,
	},
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
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- {
	-- 	"metakirby5/codi.vim",
	-- 	cmd = "Codi",
	-- },
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
		ft = { "python", "rust", "c", "c++" },
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	-- session
	-- {
	-- 	"folke/persistence.nvim",
	-- 	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	-- 	module = "persistence",
	-- 	config = function()
	-- 		require("persistence").setup({
	-- 			dir = vim.fn.expand(vim.fn.stdpath("cache") .. "/sessions/"), -- directory where session files are saved
	-- 			options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
	-- 		})
	-- 	end,
	-- },
	-- language server
	-- {
	-- note taking
}

-- DAP
local dap_install = require("dap-install")
dap_install.config("codelldb", {})
dap_install.config("ccppr_vsc", {
	adapters = {
		type = "executable",
	},
	configurations = {
		{
			type = "cpptools",
			request = "launch",
			name = "Launch with pretty-print",
			program = function()
				return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = true,
			setupCommands = {
				{
					description = "Enable pretty-printing",
					text = "-enable-pretty-printing",
				},
			},
		},
	},
})
