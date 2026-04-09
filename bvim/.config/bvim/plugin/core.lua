return {
	vim.pack.add({
		{ src = "https://github.com/kylechui/nvim-surround", name = "nvim-surround", version = vim.version.range("*") },
		{ src = "https://github.com/windwp/nvim-autopairs", name = "nvim-autopairs", version = vim.version.range("*") },
		{ src = "https://github.com/windwp/nvim-ts-autotag", name = "nvim-ts-autotag" },
		{ src = "https://github.com/okuuva/auto-save.nvim", name = "auto-save", version = vim.version.range("*") },
	}),

	vim.api.nvim_create_autocmd("InsertEnter", {
		once = true,
		callback = function()
			require("nvim-surround").setup()
			require("nvim-autopairs").setup()
			require("nvim-ts-autotag").setup()
			require("auto-save").setup()
      vim.keymap.set('n', '<leader>cW', '<cmd>ASToggle<cr>', { desc = 'Toggle Auto Save' })
		end,
	}),
}
