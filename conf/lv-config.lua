-- globals
local components = require("lvim.core.lualine.components")
require("telescope").load_extension("neoclip")
local _time = os.date("*t")
if _time.hour >= 8 and _time.hour < 18 then
	vim.o.background = "light"
else
	vim.o.background = "dark"
end
-- general
lvim.log.level = "warn"
-- breaks light themes
-- lvim.transparent_window = true
lvim.format_on_save = true
lvim.lint_on_save = true
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.gruvbox_material_palette = "original"
vim.g.sonokai_style = "maia"
vim.o.autowrite = true
vim.o.laststatus = 3
lvim.colorscheme = "gruvbox-material"
lvim.builtin.lualine.options.theme = "gruvbox"
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "catppuccino"
-- lvim.builtin.lualine.options.theme = "catppuccino"
-- lvim.colorscheme = "neon_latte"
-- lvim.colorscheme = "github_light"
-- lvim.builtin.lualine.options.theme = "ayu_light"

vim.o.timeoutlen = 150
vim.o.guifont = "JetBrains Mono Medium:h11"
vim.o.colorcolumn = "80,120"
vim.o.relativenumber = true
vim.o.spell = true
vim.o.spellfile = vim.env.HOME .. "/.config/lvim/spell/en.utf-8.add"
vim.o.spelllang = "en_us,de_de,programming"
vim.o.spelloptions = "camel"
vim.o.spellcapcheck = ""
vim.o.inccommand = "split"
-- vim.o.listchars = "tab:»·,eol:↲,nbsp:␣,extends:…,space:␣,precedes:<,extends:>,trail:·"
vim.o.listchars = "tab:»·,extends:…,precedes:<,extends:>,trail:·"
vim.o.fillchars = "eob: "
vim.o.list = true
vim.g.extra_whitespace_ignored_filetypes = { "alpha", "quickfix", "TelescopePrompt" }
vim.g.vim_markdown_folding_disabled = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.builtin.autopairs.active = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.notify.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.setup.git.enable = true
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.view.width = 40

-- keymappings
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"

-- status line
lvim.builtin.bufferline.options.separator_style = "slant"
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
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
	"cpp",
	"cmake",
	"comment",
	"css",
	"dart",
	"dockerfile",
	"dot",
	"go",
	"gomod",
	"graphql",
	"hcl",
	"html",
	"java",
	"javascript",
	"jsdoc",
	"json",
	"jsonc",
	"latex",
	"lua",
	"make",
	"php",
	"prisma",
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
		args = { "--config", vim.env.HOME .. "/.config/codespell/codespell.ini" },
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

-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(it)
-- 	return it ~= "html"
-- 		and it ~= "tailwindcss"
-- 		and it ~= "graphql"
-- 		and it ~= "zeta_note"
-- 		and it ~= "tflint"
-- 		and it ~= "ansiblels"
-- end, lvim.lsp.automatic_configuration.skipped_servers)
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands = {
	{
		"InsertEnter",
		{
			pattern = { "*" },
			command = "if &relativenumber | let g:ms_relativenumberoff = 1 | setlocal number norelativenumber | endif",
		},
	},
	{
		"InsertLeave",
		{ pattern = { "*" }, command = 'if exists("g:ms_relativenumberoff") | setlocal relativenumber | endif' },
	},
	{
		"InsertEnter",
		{ pattern = { "*" }, command = "if &cursorline | let g:ms_cursorlineoff = 1 | setlocal nocursorline | endif" },
	},
	{
		"InsertLeave",
		{ pattern = { "*" }, command = 'if exists("g:ms_cursorlineoff") | setlocal cursorline | endif' },
	},
	{ "BufRead,BufNewFile", { pattern = { "*.nomad" }, command = "set filetype=hcl" } },
	{
		"BufRead,BufNewFile",
		{ pattern = { "*.tsx" }, command = 'lua require("lvim.lsp.manager").setup("tailwindcss")' },
	},
	{ "FileType", { pattern = { "zig", "zir" }, command = "set shiftwidth=4" } },
}

-- Additional Leader bindings for WhichKey

lvim.builtin.which_key.mappings["a"] = {
	"<cmd>LvimToggleFormatOnSave<cr>",
	"Format on save",
}

lvim.builtin.which_key.mappings["B"] = {
	"<cmd>let &background = ( &background == 'dark' ? 'light' : 'dark' )<cr>",
	"Background",
}

lvim.builtin.which_key.mappings["o"] = {
	"<cmd>SymbolsOutline<CR>",
	"Outline",
}

lvim.builtin.which_key.mappings["n"] = {
	"<cmd>Neogen<CR>",
	"Doc comment",
}

lvim.builtin.which_key.mappings["i"] = {
	"<cmd>TroubleToggle<CR>",
	"Togggle Trouble",
}

lvim.builtin.which_key.mappings["t"] = {
	name = "Extra Windows",
	d = { "<cmd>TroubleToggle<CR>", "Togggle Trouble" },
	o = { "<cmd>SymbolsOutline<CR>", "Togggle Symbols Outline" },
	m = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown Browser" },
	t = { "<cmd>TodoTrouble<CR>", "Togggle Todos" },
}

lvim.builtin.which_key.mappings["dD"] = {
	"<cmd>lua require('dapui').toggle()<cr>",
	"Toggle DAP UI",
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

lvim.builtin.which_key.mappings["sy"] = {
	"<cmd>Telescope neoclip<cr>",
	"Yank History",
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
	{ "lervag/vimtex" },
	{ "Glench/Vim-Jinja2-Syntax" },
	{
		"psliwka/vim-dirtytalk",
		config = function()
			-- vim.cmd("DirtytalkUpdate")
		end,
	},
	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup({
				enable = true,
			})
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local lsp_installer_servers = require("nvim-lsp-installer.servers")
			local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")
			local extension_path = vim.env.HOME .. "/.vscode-oss/extensions/vadimcn.vscode-lldb-1.7.0"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			local opts = {
				tools = { -- rust-tools options
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
					inlay_hints = {
						only_current_line = false,
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
					settings = {
						-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
								allFeatures = true,
							},
						},
					},
					cmd_env = requested_server._default_options.cmd_env,
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
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
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	config = function()
	-- 		require("onedarkpro").load()
	-- 	end,
	-- },
	{ "mcchrish/zenbones.nvim" },
	{ "rebelot/kanagawa.nvim" },
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
		"declancm/cinnamon.nvim",
		config = function()
			require("cinnamon").setup({
				default_keymaps = true, -- Create default keymaps.
				extra_keymaps = false, -- Create extra keymaps.
				extended_keymaps = false, -- Create extended keymaps.
				override_keymaps = false, -- Replace any existing keymaps.
			})
		end,
	},
	-- {
	-- 	"karb94/neoscroll.nvim",
	-- 	config = function()
	-- 		require("neoscroll").setup()
	-- 	end,
	-- },
	{ "stevearc/dressing.nvim" },
	-- {"lukas-reineke/indent-blankline.nvim"},
	-- completion
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	},
	{
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
		},
		config = function()
			require("neoclip").setup({
				history = 1000,
				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-p>",
							paste_behind = "<c-k>",
							replay = "<c-q>", -- replay a macro
							delete = "<c-d>", -- delete an entry
							custom = {},
						},
						n = {
							select = "<cr>",
							paste = "p",
							paste_behind = "P",
							replay = "q",
							delete = "d",
							custom = {},
						},
					},
				},
			})
		end,
	},
	{ "hrsh7th/cmp-emoji" },
	{ "hrsh7th/cmp-cmdline" },
	{ "editorconfig/editorconfig-vim" },
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
	-- {
	-- 	"nvim-telescope/telescope-live-grep-args.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("live_grep_args")
	-- 	end,
	-- },
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
}

-- debugging
local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
	name = "lldb",
}
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = {
		os.getenv("HOME")
			.. "/.vscode-oss/extensions/firefox-devtools.vscode-firefox-debug-2.9.1/dist/adapter.bundle.js",
	},
}

dap.configurations.typescript = {
	name = "Debug with Firefox",
	type = "firefox",
	request = "launch",
	reAttach = true,
	url = "http://localhost:5050",
	webRoot = "${workspaceFolder}",
	firefoxExecutable = "/usr/bin/firefox-developer-edition",
}
dap.configurations.typescriptreact = { dap.configurations.typescript }
