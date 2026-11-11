vim.opt.autocomplete = true -- enable auto complete
vim.opt.autocompletedelay = 150 -- configure auto complete delay
vim.opt.autocompletetimeout = 500 -- how long to wait for completion source
vim.opt.pumheight = 7 -- hight of the completion popup
vim.opt.pummaxwidth = 40 -- width of the completion popup
vim.opt.pumborder = 'rounded'
-- o = omnifunc, . = local buffer, w = other windows, b = other buffers
vim.opt.complete = 'o,.^5,w^5,b^5'
vim.opt.completeopt = {
  'menu',
  'menuone',
  'noselect',
  'popup',
  'fuzzy',
  'nosort',
} -- completion menu options
vim.opt.autocomplete = true

vim.lsp.enable({
  'clangd',
  'gopls',
  'lua_ls',
  'ruff',
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
