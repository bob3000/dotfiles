local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

neotest.setup {
  consumers = {
    overseer = require "neotest.consumers.overseer",
  },
  overseer = {
    enabled = true,
    -- When this is true (the default), it will replace all neotest.run.* commands
    force_default = true,
  },
  adapters = {
    require "neotest-python" {
      dap = { justMyCode = false },
    },
    require "neotest-rust" {
      args = { "--no-capture" },
    },
  },
}
