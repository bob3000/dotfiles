return {
  {
    "neanias/everforest-nvim",
    lazy = true,
    config = function()
      require("everforest").setup({
        background = "hard",
        italics = true,
        sign_column_background = "grey",
        ui_contrast = "high",
        dim_inactive_windows = true,
        show_eob = false,
        transparent_background_level = 2,
        dim_inactive_windows = true,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        contrast = "soft", -- can be "hard", "soft" or empty string
        dim_inactive = true,
        transparent_mode = false,
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
