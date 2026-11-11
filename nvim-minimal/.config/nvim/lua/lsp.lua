vim.lsp.enable({
  'clangd',
  'gopls',
  'lua_ls',
  'ruff',
})

vim.opt.completeopt = {
  'menu',
  'menuone',
  'noselect',
  'popup',
  'fuzzy',
  'nosort',
} -- completion menu options

vim.opt.autocomplete = false -- enable auto complete
vim.opt.autocompletedelay = 150 -- configure auto complete delay
vim.opt.autocompletetimeout = 500 -- how long to wait for completion source
vim.opt.pumheight = 7 -- hight of the completion popup
vim.opt.pummaxwidth = 40 -- width of the completion popup
vim.opt.pumborder = 'rounded'
-- o = omnifunc, . = local buffer, w = other windows, b = other buffers
vim.opt.complete = 'o,.^5,w^5,b^5'

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local bufnr = event.buf
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = bufnr,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'user-lsp-highlight', buffer = event2.buf })
        end,
      })
    end

    -- enable linked editing if available
    if client:supports_method('textDocument/linkedEditingRange') then
      vim.lsp.linked_editing_range.enable(true, { client_id = client.id })
    end

    -- enable inline completion if available
    if client:supports_method('textDocument/inlineCompletion') then
      vim.lsp.inline_completion.enable(true, { client_id = client.id })
    end

    -- enable codelens if available
    if client:supports_method('textDocument/codeLens') then
      vim.lsp.codelens.enable(true, { client_id = client.id })
    end

    -- toggle inlay hints automatically
    if client:supports_method('textDocument/inlayHint') then
      local inlay_hints_group = vim.api.nvim_create_augroup('toggle_inlay_hints', { clear = false })

      if vim.g.auto_inlay_hints then
        -- Initial inlay hint display.
        -- Idk why but without the delay inlay hints aren't displayed at the very start.
        vim.defer_fn(function()
          local mode = vim.api.nvim_get_mode().mode
          vim.lsp.inlay_hint.enable(mode == 'n' or mode == 'v', { bufnr = bufnr })
        end, 500)
      end

      local non_normal_modes = '[vVsS\22\19iR]' -- v, V, block-v, s, S, block-s, i, R
      vim.api.nvim_create_autocmd('ModeChanged', {
        group = inlay_hints_group,
        pattern = '*:' .. non_normal_modes .. '*',
        callback = function()
          if vim.g.auto_inlay_hints then
            vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
          end
        end,
      })

      vim.api.nvim_create_autocmd('ModeChanged', {
        group = inlay_hints_group,
        pattern = non_normal_modes .. '*:*',
        callback = function()
          local new_mode = vim.fn.mode()
          if new_mode:match('^' .. non_normal_modes) then
            -- transitioning between non normal modes, skip exit
            return
          end
          if vim.g.auto_inlay_hints then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end,
      })
    end
  end,
})

-- diagnostics

local diagnostic_format = function(diagnostic)
  local diagnostic_message = {
    [vim.diagnostic.severity.ERROR] = diagnostic.message,
    [vim.diagnostic.severity.WARN] = diagnostic.message,
    [vim.diagnostic.severity.INFO] = diagnostic.message,
    [vim.diagnostic.severity.HINT] = diagnostic.message,
  }
  return diagnostic_message[diagnostic.severity]
end

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  -- virtual_lines = {
  --   current_line = true,
  --   format = diagnostic_format,
  -- },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = diagnostic_format,
  },
})
