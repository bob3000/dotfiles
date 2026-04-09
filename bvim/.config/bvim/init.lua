require("config.options")
require("config.autocmds")
require("config.keymaps")

vim.opt.background = os.getenv("appearance") or "dark"
