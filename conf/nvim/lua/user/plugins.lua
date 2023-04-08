-- install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{ "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter
	{ "numToStr/Comment.nvim" }, -- Code commenting
	{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- treesitter commenting support
	{ "kyazdani42/nvim-web-devicons" }, -- Icons
	{ "kyazdani42/nvim-tree.lua" }, -- File Explorer
	{ "akinsho/bufferline.nvim" }, -- Buffer overview
	{ "moll/vim-bbye" }, -- don't close windows on buffer close
	{ "nvim-lualine/lualine.nvim" }, -- status line
	{ "akinsho/toggleterm.nvim" }, -- terminal window
	{ "ahmedkhalf/project.nvim" }, -- switch between projects
	{ "lukas-reineke/indent-blankline.nvim" }, -- indentation markers
	{ "goolord/alpha-nvim" }, -- startup screen
	{ "LunarVim/bigfile.nvim" }, -- disable treesitter etc on big files

	-- Colorschemes
	{ "sainnhe/gruvbox-material" }, -- 👾
	{ "sainnhe/everforest" }, -- 🌳
	{ "sainnhe/sonokai" }, -- 👻
	{ "sainnhe/edge" }, -- 🎊

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" }, -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" }, -- lsp completion source
	{ "hrsh7th/cmp-nvim-lua" }, -- lua lsp completion source
	{ "hrsh7th/cmp-emoji" }, -- emoji completion source
	{ "hrsh7th/cmp-cmdline" }, -- command line completion source
	{ "f3fora/cmp-spell" }, -- spell completions
	{ "andersevenrud/cmp-tmux" }, -- tmux completions
	{ "ray-x/lsp_signature.nvim" }, -- lsp signature docs

	-- snippets
	{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, --snippet engine
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

	-- LSP
	{ "neovim/nvim-lspconfig" }, -- enable LSP
	{ "williamboman/mason.nvim" }, -- Tool installer
	{ "williamboman/mason-lspconfig.nvim" }, -- Language server configurator
	{ "jose-elias-alvarez/null-ls.nvim" }, -- for formatters and linters
	{ "RRethy/vim-illuminate" }, -- word group highlighter
	{ "b0o/schemastore.nvim" }, -- json schema store source

	-- Telescope
	{ "nvim-telescope/telescope.nvim" }, -- fuzzy finder
	{ "nvim-telescope/telescope-media-files.nvim", enabled = false }, -- does not work ATM

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter" }, -- enables treesitter

	-- Git
	{ "lewis6991/gitsigns.nvim" }, -- git hunk markers and tools

	-- DAP
	{ "mfussenegger/nvim-dap" }, -- enables debugging
	{ "rcarriga/nvim-dap-ui" }, -- Debugger UI
	{ "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } }, -- Python debugger integration
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } }, -- JS / TS debugger integration
	{ "microsoft/vscode-js-debug", version = "v1.74.1", build = "npm install --legacy-peer-deps && npm run compile" }, -- javascript debugger
	{ "leoluz/nvim-dap-go" }, -- Go debugger integration
	{ "jbyuki/one-small-step-for-vimkind" }, -- Lua debugger integration

	-- markdown
	{ "mzlogin/vim-markdown-toc" }, -- generates Table of Contents
	-- requires "luautf8"
	{ "jakewvincent/mkdnflow.nvim" }, -- wiki style md link navigation
	{ "toppair/peek.nvim", build = "deno task --quiet build:fast" }, -- markdown preview

	-- latex
	{ "jakewvincent/texmagic.nvim", lazy = true }, -- build latex

	-- rust
	{ "simrat39/rust-tools.nvim" }, -- best rust IDE experience
	{
		"Saecki/crates.nvim", -- creates update checker
		event = { "BufRead Cargo.toml" },
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	-- Node
	{
		"vuki656/package-info.nvim",
		dependencies = "MunifTanjim/nui.nvim",
	},

	-- spelling
	{
		"psliwka/vim-dirtytalk", -- programmer spelling dictionary
		build = ":DirtytalkUpdate",
	},

	-- syntax
	{ "chr4/nginx.vim" }, -- nginx syntax highlighting
	{ "Glench/Vim-Jinja2-Syntax" }, -- Jinja2 syntax highlighting
	{ "mrjones2014/nvim-ts-rainbow" }, -- Rainbow colored bracket pairs

	-- editing
	{ "tpope/vim-surround" }, -- surround text with quotes and braces
	{ "tpope/vim-repeat" }, -- better repeat command
	{
		"bronson/vim-trailing-whitespace",
		event = "VeryLazy",
		version = "907174052a504e60e9b915f5c083ee5f6e067080", -- https://github.com/bronson/vim-trailing-whitespace/issues/26
	}, -- fix trailing whitespaces
	{ "andymass/vim-matchup" }, -- better % key matching
	{ "farmergreg/vim-lastplace" }, -- remember last cursor position
	{ "windwp/nvim-ts-autotag" }, -- auto close html tags
	{ "danymat/neogen", dependencies = "nvim-treesitter/nvim-treesitter" }, -- generate comment templates
	{ "Pocco81/auto-save.nvim" }, -- save buffers automatically
	{ "chentoast/marks.nvim" }, -- display jump marks
	{ "debugloop/telescope-undo.nvim" }, -- search undo tree
	-- TODO: remove editorconfig when nvim 0.9 is released
	{ "gpanders/editorconfig.nvim" }, -- read editorconfig files

	-- search / replace
	{ "nvim-telescope/telescope-live-grep-args.nvim" }, -- limit grep search to folders
	{ "windwp/nvim-spectre" }, -- search and replace tool

	-- ui
	{ "norcalli/nvim-colorizer.lua" }, -- colorize color descriptions
	{ "declancm/cinnamon.nvim" }, -- smooth scrolling
	{ "folke/which-key.nvim" }, -- automatic key cheat sheet
	{ "folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons" }, -- diagnostics box
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" }, -- TODO marks overview
	{ "simrat39/symbols-outline.nvim" }, -- shows file structure
	{ "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig" }, -- file bread crumbs
}

local opts = {
	performance = {
		rtp = {
			reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
		},
	},
}

local ok, lazy = pcall(require, "lazy")

if ok then
	lazy.setup(plugins, opts)
end
