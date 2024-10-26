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
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      require("gruvbox").setup({
        contrast = "hard", -- can be "hard", "soft" or empty
        dim_inactive = false,
        transparent_mode = true,
        inverse = false,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
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
        colorscheme = "gruvbox",
      }
    end,
  },
}
