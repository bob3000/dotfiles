-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.opt.listchars = { -- define which invisible characters to show
  tab = '→┈',
  trail = '·',
  extends = '…',
  precedes = '…',
  nbsp = '‿',
  conceal = '￮',
}

vim.opt.fillchars = { -- define status separators
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}


local statusline = {
  '%t',
  '%r',
  '%m',
  '%=',
  '%{&filetype} ',
  ' %2p%% ',
}

vim.opt.autoread = true -- Refresh buffer contents on external change
vim.opt.autowrite = true -- Enable auto write
vim.opt.breakindent = true -- Enable break indent
vim.opt.colorcolumn = '80,120' -- show visual column after a number of chars
vim.opt.completeopt = 'menu,menuone,noselect,fuzzy,preview' -- completion menu options
vim.opt.conceallevel = 1 -- Hide * markup for bold and italic, but not markers with substitutions
vim.opt.confirm = true -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
vim.opt.cursorcolumn = true -- show vertical column where the cursor is
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.foldlevel = 99 -- fold after specified indention level
vim.opt.formatoptions = 'jcroqlnt' -- tcqj
vim.opt.grepformat = '%f:%l:%c:%m' -- grep command output format
vim.opt.grepprg = 'rg --vimgrep' -- use specified grep command for test search
vim.opt.guicursor = 'a:blinkon100,n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = 'nosplit' -- preview incremental substitute
vim.opt.jumpoptions = 'clean' -- configure jumplist behaviour
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = 'a' -- Enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.path:append '**' -- include subdirectories in search
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.ruler = false -- Disable the default ruler
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append { W = true, I = true, c = true, C = true } -- avoid certain messages
vim.opt.showbreak = '↪' -- text warp symbol
vim.opt.showmode = vim.tbl_contains(vim.v.argv, '--noplugin') -- Don't show mode if have plugins installed
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spell = true -- enable spell checking
vim.opt.spellcapcheck = '' -- don't check for capital letters after full stop
vim.opt.spelllang = { 'en' } -- spell checking in English
vim.opt.spelloptions = 'camel' -- consider camel case in spell checking
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = 'screen'
vim.opt.splitright = true -- Put new windows right of current
vim.opt.statusline = table.concat(statusline, '') -- configure basic status line
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.timeoutlen = 300 -- ms to wait for sequence to complete
vim.opt.undofile = true -- persist change history
vim.opt.undolevels = 10000 -- number of changes to keep
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.winborder = "rounded" -- rounded floating window borders
vim.opt.wrap = false -- Disable line wrap
vim.wo.foldmethod = 'expr' -- use an expression to create folds
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter to create fold expression
vim.cmd.colorscheme 'retrobox' -- set colorscheme
