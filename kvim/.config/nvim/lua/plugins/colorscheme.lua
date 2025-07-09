return {
  {
    'neanias/everforest-nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('everforest').setup {
        background = 'hard',
        italics = true,
        sign_column_background = 'grey',
        ui_contrast = 'high',
        dim_inactive_windows = false,
        show_eob = false,
        transparent_background_level = 2,
        colours_override = function(palette)
          palette.bg4 = '#a6b0a0'
        end,
      }

      vim.cmd.colorscheme 'everforest'
    end,
  },
}
