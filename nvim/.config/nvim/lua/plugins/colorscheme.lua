return {
  {
    "neanias/everforest-nvim",
    config = function()
      require("everforest").setup({
        background = "hard",
        italics = true,
        sign_column_background = "grey",
        ui_contrast = "high",
        dim_inactive_windows = true,
        show_eob = false,
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
