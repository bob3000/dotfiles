vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-context',
})

local ensure_installed = {
  'bash',
  'c',
  -- 'cmake',
  -- 'comment',
  -- 'cpp',
  -- 'css',
  -- 'diff',
  -- 'dockerfile',
  -- 'doxygen',
  -- 'editorconfig',
  'fish',
  -- 'git_config',
  -- 'gitcommit',
  -- 'gitignore',
  'go',
  -- 'gomod',
  -- 'gosum',
  -- 'gowork',
  -- 'groovy',
  -- 'hcl',
  -- 'helm',
  -- 'html',
  -- 'ini',
  -- 'javascript',
  -- 'jsdoc',
  -- 'json',
  -- 'json5',
  -- 'kitty',
  -- 'latex',
  'lua',
  'luadoc',
  -- 'make',
  'markdown',
  'markdown_inline',
  -- 'nginx',
  -- 'powershell',
  -- 'proto',
  'python',
  -- 'query',
  -- 'regex',
  -- 'ruby',
  -- 'rust',
  -- 'scss',
  -- 'sql',
  -- 'ssh_config',
  -- 'terraform',
  -- 'toml',
  -- 'tsx',
  -- 'typescript',
  -- 'vim',
  -- 'vimdoc',
  -- 'vue',
  -- 'xml',
  -- 'yaml',
  -- 'zig',
  -- 'zsh',
}

require('nvim-treesitter').install(ensure_installed)
vim.api.nvim_create_autocmd('FileType', {
  pattern = ensure_installed,
  callback = function()
    -- enable highlighting
    vim.treesitter.start()
    -- enable indention
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    -- enable folding
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
  end,
})
