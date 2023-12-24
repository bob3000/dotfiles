local colorscheme = nil
if os.getenv("SYSTEM_COLORS") == "light" then
  vim.opt.background = "light"
  colorscheme = "newpaper"
else
  vim.opt.background = "dark"
  colorscheme = "everforest"
end

return {
  { "neanias/everforest-nvim" },
  { "yorik1984/newpaper.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = colorscheme
    },
  },
}
