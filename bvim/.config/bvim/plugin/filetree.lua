vim.api.nvim_create_autocmd("User", {
  pattern = "OilEnter",
  callback = vim.schedule_wrap(function(args)
    local oil = require("oil")
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})

return {
  vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim", name = "oil", version = vim.version.range("*") },
  }),
  vim.schedule(function()
    require("oil").setup({
      default_file_explorer = true, -- NOTE: replaces netrw
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      preview_win = {
        -- How to open the preview window "load"|"scratch"|"fast_scratch"
        preview_method = "fast_scratch",
      },
      keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
        ["<C-u>"] = { "actions.preview_scroll_up", mode = "n" },
        ["<C-d>"] = { "actions.preview_scroll_down", mode = "n" },
      },
      win_options = {
        signcolumn = "yes:2",
      },
      view_options = {
        show_hidden = false,
      },
    })
  end),
  vim.keymap.set("n", "<leader>e", "<cmd>Oil --float<cr>", { desc = "Oil Explorer" }),
}
