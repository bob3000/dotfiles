return {
  {
    "jakewvincent/mkdnflow.nvim",
    event = "LazyFile",
    opts = {
      modules = {
        yaml = true,
        cmp = true,
      },
      links = {
        conceal = true,
        transform_implicit = true,
      },
      new_file_template = {
        use_template = true,
        placeholders = {
          before = {
            title = "link_title",
            date = "os_date",
          },
          after = {},
        },
        template = "# {{ title }}",
      },
      mappings = {
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
      },
    },
  },
}
