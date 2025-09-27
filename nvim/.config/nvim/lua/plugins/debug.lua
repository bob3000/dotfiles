return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<F4>',
      function()
        require('dap').terminate()
      end,
      desc = 'Debug: Terminate',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        ---@type string|nil
        local condition = vim.fn.input 'Breakpoint condition (optional): '
        ---@type string|nil
        local hit_condition = vim.fn.input 'Hit count (optional): '

        if condition == '' then
          condition = nil
        end
        if hit_condition == '' then
          hit_condition = nil
        end
        require('dap').toggle_breakpoint(condition, hit_condition)
      end,
      desc = 'Debug: Set conditional Breakpoint',
    },
    {
      '<F6>',
      function()
        require('dap').run_last()
      end,
      desc = 'Debug: Rerun last.',
    },
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Debug Nearest',
    },
    {
      '<leader>dc',
      function()
        require('dap').clear_breakpoints()
      end,
      desc = 'Clear Breakpoints',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.toggle()
      end,
      desc = 'Toggle REPL',
    },
    {
      '<leader>dl',
      function()
        require('dap').list_breakpoints()
      end,
      desc = 'List breakpoints',
    },
    {
      '<F8>',
      function()
        require('dap').step_back()
      end,
      desc = 'Step back',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('overseer').enable_dap()

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    local mason_path = vim.fn.stdpath 'data' .. '/mason'

    -- Install python specific config
    require('dap-python').setup(mason_path .. '/packages/debugpy/venv/bin/python')
    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = 'Launch file',

        -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

        program = '${file}', -- This configuration will launch the current file if used.
        pythonPath = function()
          -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
          -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
          -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
            return cwd .. '/venv/bin/python'
          elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
            return cwd .. '/.venv/bin/python'
          else
            return mason_path .. '/packages/debugpy/venv/bin/python'
          end
        end,
      },
    }

    -- C/Rust specific config
    dap.adapters.codelldb = {
      type = 'executable',
      command = mason_path .. '/bin/codelldb',
      detached = vim.fn.has 'win32' == 0,
    }

    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      {
        name = 'Select and attach to process',
        type = 'codelldb',
        request = 'attach',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
          local name = vim.fn.input 'Executable name (filter): '
          return require('dap.utils').pick_process { filter = name }
        end,
        cwd = '${workspaceFolder}',
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    -- NodeJS specific config
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = { mason_path .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    -- Chrome specific config
    dap.adapters['pwa-chrome'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = { mason_path .. '/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    -- Firefox specific config
    dap.adapters.firefox = {
      type = 'executable',
      command = 'node',
      args = { mason_path .. '/packages/firefox-debug-adapter/dist/adapter.bundle.js' },
    }

    local firefox_bin = '/usr/bin/firefox'
    if vim.fn.has 'macunix' == 1 then
      firefox_bin = '/Applications/Firefox Developer Edition.app/Contents/MacOS/firefox'
    end

    dap.configurations.javascript = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        name = 'Debug with Chrome',
        type = 'pwa-chrome',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
      },
      {
        name = 'Debug with Firefox',
        type = 'firefox',
        request = 'launch',
        reAttach = true,
        url = 'http://localhost:3000',
        webRoot = '${workspaceFolder}',
        firefoxExecutable = firefox_bin,
      },
    }

    dap.configurations.javascriptreact = dap.configurations.javascript
    dap.configurations.typescript = dap.configurations.javascript
    dap.configurations.typescriptreact = dap.configurations.javascript

    -- Install bash specific config
    dap.adapters.bashdb = {
      type = 'executable',
      command = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
      name = 'bashdb',
    }

    local bash_bin = '/bin/bash'
    if vim.fn.has 'macunix' == 1 then
      bash_bin = '/opt/homebrew/bin/bash'
    end

    dap.configurations.sh = {
      {
        type = 'bashdb',
        request = 'launch',
        name = 'Launch file',
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = vim.fn.stdpath 'data' .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
        trace = true,
        file = '${file}',
        program = '${file}',
        cwd = '${workspaceFolder}',
        pathCat = 'cat',
        pathBash = bash_bin,
        pathMkfifo = 'mkfifo',
        pathPkill = 'pkill',
        args = {},
        argsString = '',
        env = {},
        terminalKind = 'integrated',
      },
    }

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
