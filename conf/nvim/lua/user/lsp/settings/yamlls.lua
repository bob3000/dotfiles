local opts = {
  settings = {
    yaml = {
      keyOrdering = false,
      -- schemas = {
      --      ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      --      ["../path/relative/to/file.yml"] = "/.github/workflows/*"
      --      ["/path/from/root/of/project"] = "/.github/workflows/*"
      --    },
    },
  },
}

return opts
