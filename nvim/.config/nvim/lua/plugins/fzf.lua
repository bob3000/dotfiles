return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      -- Top Pickers & Explorer
      {
        '<leader><space>',
        function()
          FzfLua.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>/',
        function()
          FzfLua.live_grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>:',
        function()
          FzfLua.command_history()
        end,
        desc = 'Command History',
      },
      -- find
      {
        '<leader>fb',
        function()
          FzfLua.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fF',
        function()
          FzfLua.git_files()
        end,
        desc = 'Find Git Files',
      },
      {
        '<leader>ff',
        function()
          FzfLua.files()
        end,
        desc = 'Find Files',
      },
      -- git
      {
        '<leader>gb',
        function()
          FzfLua.git_branches()
        end,
        desc = 'Git Branches',
      },
      {
        '<leader>gs',
        function()
          FzfLua.git_status()
        end,
        desc = 'Git Status',
      },
      {
        '<leader>gS',
        function()
          FzfLua.git_stash()
        end,
        desc = 'Git Stash',
      },
      {
        '<leader>gd',
        function()
          FzfLua.git_diff()
        end,
        desc = 'Git Diff (Hunks)',
      },
      -- search
      {
        '<leader>s"',
        function()
          FzfLua.registers()
        end,
        desc = 'Registers',
      },
      {
        '<leader>s/',
        function()
          FzfLua.search_history()
        end,
        desc = 'Search History',
      },
      {
        '<leader>sa',
        function()
          FzfLua.autocmds()
        end,
        desc = 'Autocmds',
      },
      {
        '<leader>sc',
        function()
          FzfLua.command_history()
        end,
        desc = 'Command History',
      },
      {
        '<leader>sC',
        function()
          FzfLua.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>sd',
        function()
          FzfLua.diagnostics_workspace()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sD',
        function()
          FzfLua.diagnostics_document()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>sh',
        function()
          FzfLua.helptags()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sj',
        function()
          FzfLua.jumps()
        end,
        desc = 'Jumps',
      },
      {
        '<leader>sk',
        function()
          FzfLua.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          FzfLua.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sm',
        function()
          FzfLua.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>sM',
        function()
          FzfLua.manpages()
        end,
        desc = 'Man Pages',
      },
      {
        '<leader>sq',
        function()
          FzfLua.quickfix()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>uC',
        function()
          FzfLua.colorschemes()
        end,
        desc = 'Colorschemes',
      },
      -- LSP
      {
        'gd',
        function()
          FzfLua.lsp_definitions()
        end,
        desc = 'Goto Definition',
      },
      {
        'gD',
        function()
          FzfLua.lsp_declarations()
        end,
        desc = 'Goto Declaration',
      },
      {
        'grr',
        function()
          FzfLua.lsp_references()
        end,
        nowait = true,
        desc = 'References',
      },
      {
        'gri',
        function()
          FzfLua.lsp_implementations()
        end,
        desc = 'Goto Implementation',
      },
      {
        'grt',
        function()
          FzfLua.lsp_typedefs()
        end,
        desc = 'Goto Type Definition',
      },
      {
        '<leader>ss',
        function()
          FzfLua.lsp_document_symbols()
        end,
        desc = 'LSP Symbols',
      },
      {
        '<leader>sS',
        function()
          FzfLua.lsp_workspace_symbols()
        end,
        desc = 'LSP Workspace Symbols',
      },
    },
  }
}
