return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "autotools-language-server",
        "bash-language-server",
        "black",
        "gofumpt",
        "goimports",
        "prettier",
        "shfmt",
        "stylua",
      },
    },
  },
}
