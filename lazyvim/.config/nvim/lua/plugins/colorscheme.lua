return {
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup({
        transparent_background_level = 2,
      })
    end,
  },
  { "yorik1984/newpaper.nvim", event = "VeryLazy" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest"
    },
  },
}
