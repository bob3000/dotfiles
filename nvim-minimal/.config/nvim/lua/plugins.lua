vim.pack.add({
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-lualine/lualine.nvim",
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
	"https://github.com/tpope/vim-rsi",
	{ src = "https://github.com/stevearc/conform.nvim", version = vim.version.range("*") },
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/mfussenegger/nvim-lint",
	"https://github.com/jakewvincent/mkdnflow.nvim",
	{ src = "https://github.com/stevearc/oil.nvim", version = vim.version.range("*") },
	"https://github.com/neovim/nvim-lspconfig",
})

-- ───────────────────────── oil ─────────────────────────
require("oil").setup({
	default_file_explorer = true, -- NOTE: replaces netrw
	columns = {
		"icon",
		-- 'permissions',
		-- 'size',
		-- 'mtime',
	},
	preview_win = {
		-- how to open the preview window: 'load' | 'scratch' | 'fast_scratch'
		preview_method = "fast_scratch",
	},
	keymaps = {
		["g?"] = { "actions.show_help", mode = "n" },
		["<CR>"] = "actions.select",
		["<C-s>"] = { "actions.select", opts = { vertical = true } },
		["<C-h>"] = { "actions.select", opts = { horizontal = true } },
		["<C-t>"] = { "actions.select", opts = { tab = true } },
		["<C-p>"] = "actions.preview",
		["<C-c>"] = { "actions.close", mode = "n" },
		["<leader>e"] = { "actions.close", mode = "n" },
		["<C-l>"] = "actions.refresh",
		["-"] = { "actions.parent", mode = "n" },
		["_"] = { "actions.open_cwd", mode = "n" },
		["`"] = { "actions.cd", mode = "n" },
		["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		["gs"] = { "actions.change_sort", mode = "n" },
		["gx"] = "actions.open_external",
		["g."] = { "actions.toggle_hidden", mode = "n" },
		["g\\"] = { "actions.toggle_trash", mode = "n" },
		["<C-u>"] = { "actions.preview_scroll_up", mode = "n" },
		["<C-d>"] = { "actions.preview_scroll_down", mode = "n" },
	},
	win_options = {
		signcolumn = "yes:2",
	},
	view_options = {
		show_hidden = false,
	},
	float = {
		padding = 1, -- padding around the floating window
		-- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		max_width = 0.3,
		max_height = 0.8,
		override = function(conf)
			conf.style = "minimal"
			return conf
		end,
	},
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil --float<cr>", { desc = "Oil Explorer" })

-- ───────────────────────── fzf-lua ─────────────────────────
local fzf = require("fzf-lua")
fzf.setup({})

-- pick(lhs, picker name, description, { mode = ..., nowait = ..., args = { ... } })
local function pick(lhs, name, desc, o)
	o = o or {}
	vim.keymap.set(o.mode or "n", lhs, function()
		fzf[name](o.args)
	end, { desc = desc, nowait = o.nowait })
end

pick("<leader><space>", "global", "Smart Find Files")
pick("<leader>/", "live_grep", "Grep")
pick("<leader>:", "command_history", "Command History")
-- find
pick("<leader>fb", "buffers", "Buffers")
pick("<leader>fc", "files", "Find Config File", { args = { cwd = vim.fn.stdpath("config") } })
pick("<leader>ff", "files", "Find Files")
pick("<leader>fg", "git_files", "Find Git Files")
pick("<leader>fr", "oldfiles", "Recent")
-- git
pick("<leader>gb", "git_branches", "Git Branches")
pick("<leader>gl", "git_commits", "Git Log")
pick("<leader>gs", "git_status", "Git Status")
pick("<leader>gS", "git_stash", "Git Stash")
pick("<leader>gd", "git_hunks", "Git Diff (Hunks)")
pick("<leader>gf", "git_bcommits", "Git Log File")
-- grep and search
pick("<leader>sb", "blines", "Buffer Lines")
pick("<leader>sB", "lines", "Grep Open Buffers")
pick("<leader>sg", "live_grep", "Grep")
pick("<leader>sw", "grep_cword", "Word under cursor")
pick("<leader>sw", "grep_visual", "Visual selection", { mode = "x" })
pick('<leader>s"', "registers", "Registers")
pick("<leader>s/", "search_history", "Search History")
pick("<leader>sa", "autocmds", "Autocmds")
pick("<leader>sc", "command_history", "Command History")
pick("<leader>sC", "commands", "Commands")
pick("<leader>sd", "diagnostics_workspace", "Diagnostics")
pick("<leader>sD", "diagnostics_document", "Buffer Diagnostics")
pick("<leader>sh", "helptags", "Help Pages")
pick("<leader>sH", "highlights", "Highlights")
pick("<leader>sj", "jumps", "Jumps")
pick("<leader>sk", "keymaps", "Keymaps")
pick("<leader>sl", "loclist", "Location List")
pick("<leader>sm", "marks", "Marks")
pick("<leader>sM", "manpages", "Man Pages")
pick("<leader>sq", "quickfix", "Quickfix List")
pick("<leader>sR", "resume", "Resume")
pick("<leader>su", "undotree", "Undo History")
pick("<leader>uC", "colorschemes", "Colorschemes")
-- LSP
pick("gd", "lsp_definitions", "Goto Definition")
pick("gD", "lsp_declarations", "Goto Declaration")
pick("grr", "lsp_references", "References", { nowait = true })
pick("gri", "lsp_implementations", "Goto Implementation")
pick("grt", "lsp_typedefs", "Goto Type Definition")
pick("<leader>ss", "lsp_document_symbols", "LSP Symbols")
pick("<leader>sS", "lsp_live_workspace_symbols", "LSP Workspace Symbols")

-- ───────────────────────── editing helpers ─────────────────────────
-- mini.nvim
vim.keymap.set("n", "gs", function()
	require("mini.splitjoin").toggle()
end, { desc = "Join/split code block" })

local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require("mini.surround").setup()
require("mini.icons").setup()
require("mini.pairs").setup()

-- ───────────────────────── lualine ─────────────────────────
require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = vim.o.laststatus == 3,
		always_show_tabline = true,
	},
	sections = {
		lualine_b = {
			"branch",
			{
				"diff",
				source = function()
					local gitsigns = vim.b.gitsigns_status_dict
					if gitsigns then
						return { added = gitsigns.added, modified = gitsigns.changed, removed = gitsigns.removed }
					end
				end,
			},
			"diagnostics",
		},
		lualine_x = {
			"encoding",
			"fileformat",
			"filetype",
		},
		lualine_z = {
			"location",
			{
				function()
					if vim.tbl_contains({ "v", "V" }, vim.fn.mode()) then
						return string.format("%d words", vim.fn.wordcount()["visual_words"])
					end
					return ""
				end,
			},
			"lsp_status",
		},
	},
	winbar = {
		lualine_c = {
			{
				"filename",
				newfile_status = true,
				symbols = { modified = "", readonly = " ", unnamed = "󰘓 ", newfile = " " },
			},
		},
	},
	inactive_winbar = {
		lualine_c = {
			{
				"filename",
				newfile_status = true,
				symbols = { modified = "", readonly = " ", unnamed = "[No Name]", newfile = "[New]" },
			},
		},
	},
	tabline = {
		lualine_a = {
			{
				"buffers",
				use_mode_colors = false,
				filetype_names = {},
				symbols = { modified = " ●", alternate_file = " ", directory = "" },
			},
		},
		lualine_z = {
			{
				"tabs",
				show_modified_status = true,
				symbols = { modified = " ●" },
			},
		},
	},
})

-- ───────────────────────── conform ─────────────────────────
require("conform").setup({
	notify_on_error = false,
	format_on_save = false,
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		fish = { "fish_indent" },
		lua = { "stylua" },
		python = { "ruff_format", "ruff_organize_imports" },
	},
})
vim.keymap.set("", "<leader>cf", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- ───────────────────────── gitsigns ─────────────────────────
require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next git [c]hange" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git [c]hange" })

		-- actions, visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "stage hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "reset hunk" })
		-- actions, normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "stage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "reset hunk" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "stage buffer" })
		map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "undo stage hunk" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "reset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "preview hunk" })
		map("n", "<leader>hb", gitsigns.blame_line, { desc = "blame line" })
		map("n", "<leader>hF", gitsigns.blame, { desc = "blame file" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "diff against index" })
		map("n", "<leader>hD", function()
			gitsigns.diffthis("HEAD~1")
		end, { desc = "diff against last commit" })
		-- toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "toggle git show blame line" })
		map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "toggle git show deleted" })
	end,
})

-- ───────────────────────── nvim-lint ─────────────────────────
local lint = require("lint")
lint.linters_by_ft = {
	cmake = { "cmakelint" },
	dockerfile = { "hadolint" },
	fish = { "fish" },
	go = { "golangcilint" },
	javascript = { "biomejs" },
	javascriptreact = { "biomejs" },
	json = { "biomejs" },
	markdown = { "markdownlint-cli2" },
	terraform = { "tflint" },
	typescript = { "biomejs" },
	typescriptreact = { "biomejs" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		-- only lint buffers that can be modified, to avoid noise in LSP pop-ups
		if vim.bo.modifiable then
			lint.try_lint(nil, { ignore_errors = true })
		end
	end,
})

-- ───────────────────────── mkdnflow ─────────────────────────
require("mkdnflow").setup({
	modules = { yaml = true, completion = false },
	links = { conceal = true, transform_implicit = true },
	new_file_template = {
		use_template = true,
		template = "# {{ title }} - {{ date }}\n",
	},
	mappings = {
		MkdnCreateLinkFromClipboard = { { "n", "v" }, "<leader>Np" },
		MkdnUpdateNumbering = { "n", "<leader>Nn" },
		MkdnTableNewRowBelow = { "n", "<leader>Nr" },
		MkdnTableNewRowAbove = { "n", "<leader>NR" },
		MkdnTableNewColAfter = { "n", "<leader>Nc" },
		MkdnTableNewColBefore = { "n", "<leader>NC" },
		MkdnFoldSection = { "n", "<leader>Nf" },
		MkdnUnfoldSection = { "n", "<leader>NF" },
	},
})
