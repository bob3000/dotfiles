local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

M.attach_keymaps = function(_, bufnr)
  local keymap = vim.keymap
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  keymap.set("v", "<leader>la", vim.lsp.buf.code_action, bufopts)
  -- keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- keymap.set("n", "<space>wl", function()
  -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)

  local which_key_ok, which_key = pcall(require, "which-key")
  if which_key_ok then
    local whichkey_opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
      l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        D = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Definitions" },
        W = {
          "<cmd>FixWhitespace<CR>",
          "Fix Whitespace",
        },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        I = { "<cmd>Mason<cr>", "Mason Info" },
        j = {
          vim.diagnostic.goto_next,
          "Next Diagnostic",
        },
        k = {
          vim.diagnostic.goto_prev,
          "Prev Diagnostic",
        },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        R = {
          "<Esc><cmd>lua require('refactoring').select_refactor()<cr>",
          "Refactor",
        },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
        e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
      },
    }

    if bufnr ~= nil then
      whichkey_opts.buffer = bufnr
    end
    which_key.register(mappings, whichkey_opts)
  end
end

M.on_attach = function(client, bufnr)
  M.attach_keymaps(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  local illuminate_ok, illuminate = pcall(require, "illuminate")
  if illuminate_ok then
    illuminate.on_attach(client)
  end

  local navic_ok, navic = pcall(require, "nvim-navic")
  if navic_ok then
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end
  end
end

return M
