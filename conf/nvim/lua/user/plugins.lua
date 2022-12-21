local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  snapshot_path = vim.fn.stdpath("config") .. "/plugin",
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  git = {
    clone_timeout = 300, -- Timeout, in seconds, for git clones
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" } -- Code commenting
  use { "JoosepAlviste/nvim-ts-context-commentstring" } -- treesitter commenting support
  use { "kyazdani42/nvim-web-devicons" } -- Icons
  use { "kyazdani42/nvim-tree.lua" } -- File Explorer
  use { "akinsho/bufferline.nvim" } -- Buffer overview
  use { "moll/vim-bbye" } -- don't close windows on buffer close
  use { "nvim-lualine/lualine.nvim" } -- status line
  use { "akinsho/toggleterm.nvim" } -- terminal window
  use { "ahmedkhalf/project.nvim" } -- switch between projects
  use { "lewis6991/impatient.nvim" } -- module resolution cache
  use { "lukas-reineke/indent-blankline.nvim" } -- indention markers
  use { "goolord/alpha-nvim" } -- startup screen
  use { "LunarVim/bigfile.nvim" } -- disable treesitter etc on big files

  -- Colorschemes
	use { "sainnhe/gruvbox-material" } -- 👾
	use { "sainnhe/everforest" } -- 🌳
	use { "sainnhe/sonokai" } -- 👻
	use { "sainnhe/edge" } -- 🎊

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" } -- lsp completion source
  use { "hrsh7th/cmp-nvim-lua" } -- lua lsp completion source
	use { "hrsh7th/cmp-emoji" } -- emoji completion source
	use { "hrsh7th/cmp-cmdline" } -- command line completion source
  use { "ray-x/lsp_signature.nvim" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/mason.nvim" } -- Tool installer
  use { "williamboman/mason-lspconfig.nvim" } -- Language server configurator
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate" } -- word group highlighter
  use { "b0o/schemastore.nvim"} -- json schema store source

  -- Telescope
  use { "nvim-telescope/telescope.nvim" } -- fuzzy finder
  use { "nvim-telescope/telescope-media-files.nvim", disable = true } -- does not work ATM

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" } -- enables treesitter

  -- Git
  use { "lewis6991/gitsigns.nvim" } -- git hunk markers and tools

  -- DAP
  use { "mfussenegger/nvim-dap" } -- enables debugging
  use { "rcarriga/nvim-dap-ui" } -- Debugger UI
  use { "mfussenegger/nvim-dap-python", requires = {"mfussenegger/nvim-dap"} } -- Python debugger integration
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} } -- JS / TS debugger integration
  use { "leoluz/nvim-dap-go" } -- Go debugger integration

	-- markdown
	use { "mzlogin/vim-markdown-toc" } -- generates Table of Contents
	use { "jakewvincent/mkdnflow.nvim", rocks = "luautf8" } -- wiki style md link navigation
	use { "toppair/peek.nvim", run = "deno task --quiet build:fast" } -- markdown preview

  -- rust
  use { "simrat39/rust-tools.nvim" } -- best rust IDE experience
	use { "Saecki/crates.nvim", -- creates update checker
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
	}

  -- Node
  use {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
  }

	-- spelling
	use {
		"psliwka/vim-dirtytalk", -- programmer spelling dictionary
		run = ":DirtytalkUpdate",
	}
	-- syntax
	use { "chr4/nginx.vim" } -- nginx syntax highlighting
	use { "Glench/Vim-Jinja2-Syntax" } -- Jinja2 syntax highlighting
  use { "p00f/nvim-ts-rainbow" } -- Rainbow colored bracket pairs

	-- editing
	use { "tpope/vim-surround" } -- surround text with quotes and braces
	use { "tpope/vim-repeat" } -- better repeat command
	use { "bronson/vim-trailing-whitespace" } -- fix trailing whitespaces
	use { "andymass/vim-matchup" } -- better % key matching
  use { "farmergreg/vim-lastplace" } -- remember last cursor position
	use { "windwp/nvim-ts-autotag" } -- auto close html tags
	use { "danymat/neogen", requires = "nvim-treesitter/nvim-treesitter" } -- generate comment templates
  use { "Pocco81/auto-save.nvim" } -- save buffers automatically
  use { "chentoast/marks.nvim" } -- display jump marks

	-- search / replace
	use { "nvim-telescope/telescope-live-grep-args.nvim" } -- limit grep search to folders
	use { "windwp/nvim-spectre" } -- search and replace tool

  -- ui
	use { "norcalli/nvim-colorizer.lua" } -- colorize color descriptions
  use { "declancm/cinnamon.nvim" } -- smooth scrolling
  use { "folke/which-key.nvim" } -- automatic key cheat sheet
  use { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" } -- diagnostics box
  use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" } -- TODO marks overview
  use { "simrat39/symbols-outline.nvim" } -- shows file structure
  use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" } -- file bread crumbs

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
