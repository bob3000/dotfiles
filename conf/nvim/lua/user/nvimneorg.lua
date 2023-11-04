local M = {}

M.setup = function()
  local status_ok, neorg = pcall(require, "neorg")
  if not status_ok then
    return
  end

  neorg.setup {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.summary"] = {}, -- create index files
      ["core.export.markdown"] = {}, -- markdown export
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      }, -- completion engine
      -- calendar requires nvim > 0.10.0
      -- ["core.ui.calendar"] = {}, -- calendar widget
      ["core.presenter"] = {
        config = {
          zen_mode = "zen-mode",
        }
      }, -- presentation mode
      ["core.integrations.telescope"] = {}, -- telescope plugin
      ["core.concealer"] = {
        config = {
          icon_preset = "varied",
        },
      }, -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/Nextcloud/Synced/neorg/workspaces/notes",
            work = "~/Nextcloud/Synced/neorg/workspaces/work",
            default_workspace = "work"
          },
        },
      },
    },
  }
end

return M
