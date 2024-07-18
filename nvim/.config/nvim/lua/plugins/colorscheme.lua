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
  {
    "LazyVim/LazyVim",
    opts = function()
      if vim.g.neovide then
        return {
          colorscheme = "tokyonight",
        }
      end
      return {
        colorscheme = "everforest",
      }
    end,
  },
}
