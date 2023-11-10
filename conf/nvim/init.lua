require "user.options"
require "user.plugins"
require "user.keymaps" -- has to run after plugins for some keymaps to work
-- plugin config
require "user.imagenvim"
require "user.autocommands"
require "user.colorscheme"
require "user.telescope"
require "user.gitsigns"
require "user.gitconflict"
require "user.treesitter"
require "user.autopairs"
require "user.comment"
require "user.nvim-tree"
require "user.bufferline"
require "user.lualine"
require "user.toggleterm"
require "user.project"
require "user.illuminate"
require "user.indentline"
require "user.alpha"
require "user.lsp"
require "user.dap" -- run before overseer
require "user.cratesnvim" -- put before cmp and after lsp
require "user.cmp"
require "user.rusttools"
require "user.whichkey"
require "user.peeknvim"
require "user.troublenvim"
require "user.mkdnflow"
require "user.outline"
require "user.overseernvim"
require "user.zenmode"
require "user.noice"
require "user.neotest"
require "user.trysetup"
require "user.neovide"
