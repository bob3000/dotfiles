-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-A-l>", "<cmd>BufferLineMoveNext<CR>", opts)
keymap("n", "<S-A-h>", "<cmd>BufferLineMovePrev<CR>", opts)
keymap("n", "<S-A-p>", "<cmd>BufferLineTogglePin<CR>", opts)
keymap("n", "gB", "<cmd>BufferLinePick<CR>", opts)

-- sort visual lines
keymap("v", "gs", ":'<,'>sort<CR>", opts)

-- luasnip
local luasnip_ok, ls = pcall(require, "luasnip")
if luasnip_ok then
  keymap("i", "<C-l>", function()
    ls.jump(1)
  end, opts)
  keymap("i", "<C-h>", function()
    ls.jump(-1)
  end, opts)
end

-- Better paste
keymap("v", "p", '"_dP', opts)

-- refactor
keymap("v", "<leader>lR",
 "<Esc><cmd>lua require('refactoring').select_refactor()<cr>")

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
