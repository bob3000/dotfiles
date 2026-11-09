-- code
vim.keymap.set("", "<leader>cw", "<cmd>%s/ \\+$//<CR>", { desc = "Remove trailing whitespace" })
vim.keymap.set("", "<leader>co", ":'<,'>sort<CR>", { desc = "Order lines" })

-- marks
vim.keymap.set("", "dm", ":execute 'delmarks '.nr2char(getchar())<CR>", { desc = "Delete mark" })
vim.keymap.set("", "dm*", ":delmarks!<CR>", { desc = "Delete all marks" })

-- diagnostics
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix"} )
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist"} )
