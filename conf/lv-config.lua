-- vim:ts=2:sw=2:ai:foldmethod=marker:foldlevel=0:

-- imports
-- {{{
local components = require("lvim.core.lualine.components")
local _time = os.date("*t")
if _time.hour >= 8 and _time.hour < 18 then
	vim.o.background = "light"
else
	vim.o.background = "dark"
end
-- }}}

-- nvim config
-- {{{
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
vim.o.listchars = "tab:»·,extends:…,precedes:<,extends:>,trail:·"
vim.o.fillchars = "eob: "
vim.o.list = true
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, {
  "rust_analyzer",
})
-- }}}

-- globals
-- {{{
vim.g.gruvbox_material_palette = "original"
vim.g.extra_whitespace_ignored_filetypes = { "alpha", "quickfix", "TelescopePrompt" }
vim.g.vim_markdown_folding_disabled = true
-- }}}

-- lvim config
-- {{{
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"
lvim.leader = "space"
lvim.builtin.autopairs.active = true
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.setup.git.enable = true
lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.hijack_netrw = false
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.lualine.options.theme = "gruvbox"
lvim.colorscheme = "gruvbox-material"
-- }}}

-- status line
-- {{{
lvim.builtin.bufferline.options.separator_style = "slant"
lvim.builtin.lualine.options.component_separators = { left = "", right = "" }
lvim.builtin.lualine.options.section_separators = { left = "", right = "" }
lvim.builtin.lualine.sections.lualine_z = {
	components.scrollbar,
	"(vim.fn.mode() == 'v' or vim.fn.mode() == 'V') and string.format('%d words', vim.fn.wordcount()['visual_words'])",
}
-- }}}

-- treesitter
-- {{{
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
	"sql",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"yaml",
	"zig",
}
lvim.builtin.treesitter.highlight.enabled = true
-- }}}

-- keymappings
-- {{{
lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Additional Leader bindings for WhichKey

lvim.builtin.which_key.mappings["a"] = {
	"<cmd>LvimToggleFormatOnSave<cr>",
	"Format on save",
}

lvim.builtin.which_key.mappings["B"] = {
	"<cmd>let &background = ( &background == 'dark' ? 'light' : 'dark' )<cr>",
	"Background",
}

lvim.builtin.which_key.mappings["n"] = {
	"<cmd>Neogen<CR>",
	"Doc comment",
}

lvim.builtin.which_key.mappings["i"] = {
	"<cmd>TroubleToggle<CR>",
	"Toggle Trouble",
}

lvim.builtin.which_key.mappings["t"] = {
	name = "Extra Windows",
	d = { "<cmd>TroubleToggle<CR>", "Togggle Trouble" },
	m = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown Browser" },
	t = { "<cmd>TodoTrouble<CR>", "Togggle Todos" },
}

lvim.builtin.which_key.mappings["dD"] = {
	"<cmd>lua require('dapui').toggle()<cr>",
	"Toggle DAP UI",
}

lvim.builtin.which_key.mappings["lt"] = {
	"<cmd>FixWhitespace<cr>",
	"Trim trailing spaces",
}

lvim.builtin.which_key.mappings["sg"] = {
	"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
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
-- }}}

-- linters
-- {{{
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
-- }}}

-- formatters
-- {{{
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ exe = "black" },
	{ exe = "shfmt", args = { "-i", "2", "-bn", "-sr", "-ci" } },
	{ exe = "stylua" },
	{
		exe = "prettier",
		filetypes = { "javascript", "typescript", "typescriptreact", "json" },
	},
	{ name = "npm_groovy_lint" },
})
-- }}}

-- autocommands
-- {{{
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
	{ "BufRead,BufNewFile", { pattern = { "Jenkinsfile.*", "Jenkinsfile" }, command = "set filetype=groovy" } },
	{
		"BufRead,BufNewFile",
		{ pattern = { "*.tsx" }, command = 'lua require("lvim.lsp.manager").setup("tailwindcss")' },
	},
	{ "FileType", { pattern = { "zig", "zir" }, command = "set shiftwidth=4" } },
}
-- }}}

-- Additional Plugins
-- {{{
lvim.plugins = {
  -- color
	{ "rktjmp/lush.nvim" },
	{ "sainnhe/gruvbox-material" },
	{ "rebelot/kanagawa.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
  -- style
	{ "stevearc/dressing.nvim" },
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
  -- spelling
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
	-- syntax
	{ "chr4/nginx.vim" },
	{ "Glench/Vim-Jinja2-Syntax" },
	-- navigation
	{
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
  -- markdown
	{ "plasticboy/vim-markdown" },
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	},
  -- rust
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local opts = {
				tools = {
					executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
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
				server = {
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			}
			local extension_path = vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.3/"

			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

			opts.dap = {
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
			}
			require("rust-tools").setup(opts)
		end,
		ft = { "rust", "rs" },
	},
	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup()
		end,
	},
	-- completion
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	},
	{ "hrsh7th/cmp-emoji" },
	{ "hrsh7th/cmp-cmdline" },
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
	{
		"nvim-telescope/telescope-live-grep-args.nvim",
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"windwp/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},
	-- debugging
	{
		"nvim-telescope/telescope-dap.nvim",
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
}
-- }}}

-- debugging
-- {{{
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
-- }}}
