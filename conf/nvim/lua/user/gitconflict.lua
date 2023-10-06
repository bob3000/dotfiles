local status_ok, conflict = pcall(require, "git-conflict")
if not status_ok then
  return
end

local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
  conflict.setup {
    default_mappings = true, -- disable buffer local mapping created by this plugin
    default_commands = true, -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = trouble.open "quickfix", -- command or function to open the conflicts list
    highlights = { -- They must have background color, otherwise the default color will be used
      incoming = "DiffAdd",
      current = "DiffText",
    },
  }
else
  conflict.setup {}
end
