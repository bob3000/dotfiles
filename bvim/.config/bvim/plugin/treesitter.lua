local ensure_installed = {
	"bash",
	"c",
	"cmake",
	"comment",
	"cpp",
	"css",
	"diff",
	"dockerfile",
	"doxygen",
	"editorconfig",
	"fish",
	"git_config",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"gowork",
	"groovy",
	"hcl",
	"helm",
	"html",
	"ini",
	"javascript",
	"jsdoc",
	"json",
	"json5",
	"kitty",
	"latex",
	"lua",
	"luadoc",
	"make",
	"markdown",
	"markdown_inline",
	"nginx",
	"powershell",
	"proto",
	"python",
	"query",
	"regex",
	"ruby",
	"rust",
	"scss",
	"sql",
	"ssh_config",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"vue",
	"xml",
	"yaml",
	"zig",
	"zsh",
}

return {
	vim.api.nvim_create_autocmd("PackChanged", {
		callback = function(ev)
			local name, kind = ev.data.spec.name, ev.data.kind
			if name == "nvim-treesitter" and kind == "update" then
				if not ev.data.active then
					vim.cmd.packadd("nvim-treesitter")
				end
				vim.cmd("TSUpdate")
			end
		end,
	}),
	vim.pack.add({
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter", version = "main" },
		{
			src = "https://github.com/nvim-treesitter/nvim-treesitter-context",
			name = "nvim-treesitter-context",
			version = "master",
		},
	}),
  require('nvim-treesitter').install(ensure_installed)
}
