return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        -- use native inlay hints instead
        inlay_hints = { auto = false },
      },
    },
  },
}
