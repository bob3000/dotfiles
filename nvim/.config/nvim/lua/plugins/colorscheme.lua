return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("everforest").setup({
        background = "soft",
        italics = true,
        sign_column_background = "grey",
        ui_contrast = "high",
        dim_inactive_windows = false,
        show_eob = false,
        transparent_background_level = 2,
        colours_override = function(palette)
          palette.bg4 = "#a6b0a0"
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = function()
      if vim.g.neovide then
        return {
          colorscheme = "gruvbox",
        }
      end
      return {
        colorscheme = "everforest",
      }
    end,
  },
}
