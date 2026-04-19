-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- toggle inlay hints when switching between normal / insert mode
vim.g.auto_inlay_hints = true

-- [[ Setting options ]]
-- See `:help vim.o`

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.opt.listchars = { -- define which invisible characters to show
	tab = "→┈",
	trail = "·",
	extends = "…",
	precedes = "…",
	nbsp = "‿",
	conceal = "￮",
}

vim.opt.fillchars = { -- define status separators
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

local statusline = {
	"%t",
	"%r",
	"%m",
	"%=",
	"%{&filetype} ",
	" %2p%% ",
}

vim.opt.autoread = true -- Refresh buffer contents on external change
vim.opt.autowrite = true -- Enable auto write
vim.opt.breakindent = true -- Enable break indent
vim.opt.colorcolumn = "80,120" -- show visual column after a number of chars
vim.opt.completeopt = "menu,menuone,noselect,fuzzy,preview" -- completion menu options
vim.opt.conceallevel = 1 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
vim.opt.cursorcolumn = true -- show vertical column where the cursor is
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.foldlevel = 99 -- fold after specified indention level
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m" -- grep command output format
vim.opt.grepprg = "rg --vimgrep" -- use specified grep command for test search
vim.opt.guicursor = "a:blinkon100,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.jumpoptions = "clean" -- configure jumplist behaviour
vim.opt.keywordprg = ":help!" -- what to do when K is pressed
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.ruler = false -- Disable the default ruler
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append({ W = true, I = false, c = true, C = true }) -- avoid certain messages
vim.opt.showbreak = "↪" -- text warp symbol
vim.opt.showmode = vim.tbl_contains(vim.v.argv, "--noplugin") -- Don't show mode if have plugins installed
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spell = true -- enable spell checking
vim.opt.spellcapcheck = "" -- don't check for capital letters after full stop
vim.opt.spelllang = { "en" } -- spell checking in English
vim.opt.spelloptions = "camel" -- consider camel case in spell checking
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true -- Put new windows right of current
vim.opt.statusline = table.concat(statusline, "") -- configure basic status line
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 600 -- ms to wait for sequence to complete
vim.opt.undofile = true -- persist change history
vim.opt.undolevels = 10000 -- number of changes to keep
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.winborder = "rounded" -- rounded floating window borders
vim.opt.wrap = false -- Disable line wrap
vim.wo.foldmethod = "expr" -- use an expression to create folds
vim.lsp.log.set_level(vim.log.levels.OFF) -- disable lsp logs
vim.cmd.colorscheme("retrobox") -- set colorscheme

-- Disable health checks for these providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
-- Stop luasnip from making the cursor jump
--  See `:help hlsearch`
vim.keymap.set({ "i", "s", "n" }, "<esc>", function()
	vim.cmd("noh")
	return "<esc>"
end, { desc = "Escape, clear hlsearch", expr = true })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ "x", "n", "s" }, "<C-c>", "<cmd>bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Terminal Mappings
vim.keymap.set("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set({ "x", "n", "s" }, "<C-q>", function()
	pcall(vim.api.nvim_win_close, 0, false)
end, { desc = "Close window" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- insert newline without ending up in insert mode
vim.keymap.set("n", "<S-Enter>", "i<Enter><Esc>l", { desc = "Insert newline below" })

-- delete line without yanking
vim.keymap.set("n", "<leader>dd", '"_dd', { desc = "Delete line without yanking" })

-- delete till end of the line line without yanking
vim.keymap.set("n", "<leader><S-d>", '"_D', { desc = "Delete till end of line without yanking" })

-- Undotree
vim.keymap.set("n", "<leader><S-u>", function()
	require("undotree").open()
end, { desc = "Undotree" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local function augroup(name)
	return vim.api.nvim_create_augroup("svim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].svim_last_loc then
			return
		end
		vim.b[buf].svim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"checkhealth",
		"help",
		"lspinfo",
		"notify",
		"nvim-undotree",
		"qf",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
		vim.opt.cursorline = false
		vim.opt.cursorcolumn = false
	end,
})

-- switch to relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
		vim.opt.cursorline = true
		vim.opt.cursorcolumn = true
	end,
})
