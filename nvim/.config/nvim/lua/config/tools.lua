return {
  servers = {
    'bashls',
    -- 'clangd',
    -- 'cssls',
    'gopls',
    'dockerls',
    'docker_compose_language_service',
    'helm_ls',
    'biome',
    -- 'html',
    'jsonls', -- still complements biome
    -- 'neocmake',
    'ruff',
    -- 'rust_analyzer',
    'sqruff',
    -- 'stylelint-language-server',
    'terraformls',
    'tflint',
    'tsgo',
    'lua_ls',
    'yamlls',
    'taplo',
    'ty',
  },

  -- list will be merged with the language servers listed above
  tools = {
    -- 'bash-debug-adapter', -- mildly useful
    -- 'cmakelang',
    -- 'cmakelint',
    -- 'codelldb',
    -- 'debugpy', -- usually installed within the project
    'delve',
    -- 'firefox-debug-adapter',
    'gofumpt',
    'goimports',
    'hadolint',
    -- 'js-debug-adapter',
    'markdownlint',
    'markdown-toc',
    'shellcheck',
    'shfmt',
    'stylua',
  },
}
