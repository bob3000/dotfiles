local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
  return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "dot",
    "doxygen",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gowork",
    "gpg",
    "graphql",
    "groovy",
    "hcl",
    "html",
    "ini",
    "java",
    "javascript",
    "json",
    "json5",
    "jsonc",
    "jq",
    "kotlin",
    "latex",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "meson",
    "php",
    "prisma",
    "python",
    "regex",
    "rst",
    "ruby",
    "rust",
    "scss",
    "ssh_config",
    "sql",
    "svelte",
    "terraform",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    "zig",
  }, -- put the language you want in this array
  -- ensure_installed = "all", -- one of "all" or a list of languages
  ignore_install = { "" }, -- List of parsers to ignore installing
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
