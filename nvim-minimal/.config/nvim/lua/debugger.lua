vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/igorlfs/nvim-dap-view',
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/mfussenegger/nvim-dap-python',
})

local dap = require('dap')
-- dap.set_log_level('TRACE')
local dapview = require('dap-view')

-- Change breakpoint icons
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })

dap.listeners.after.event_initialized['dapui_config'] = dapview.open
dap.listeners.before.event_terminated['dapui_config'] = dapview.close
dap.listeners.before.event_exited['dapui_config'] = dapview.close

-- Install python specific config
require('dap-python').setup('uv')

-- C/Rust specific config
dap.adapters.codelldb = {
  type = 'executable',
  command = 'codelldb',
  detached = vim.fn.has('win32') == 0,
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
      local name = vim.fn.input('Executable name (filter): ')
      return require('dap.utils').pick_process({ filter = name })
    end,
    cwd = '${workspaceFolder}',
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Install golang specific config
require('dap-go').setup({
  delve = {
    -- On Windows delve must be run attached or it crashes.
    -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    detached = vim.fn.has('win32') == 0,
  },
})

local keys = {
  {
    key = '<leader>5',
    action = function()
      require('dap').continue()
    end,
    desc = 'Debug: Start/Continue',
  },
  {
    key = '<leader>1',
    action = function()
      require('dap').step_into()
    end,
    desc = 'Debug: Step Into',
  },
  {
    key = '<leader>2',
    action = function()
      require('dap').step_over()
    end,
    desc = 'Debug: Step Over',
  },
  {
    key = '<leader>3',
    action = function()
      require('dap').step_out()
    end,
    desc = 'Debug: Step Out',
  },
  {
    key = '<leader>4',
    action = function()
      require('dap').terminate()
    end,
    desc = 'Debug: Terminate',
  },
  {
    key = '<leader>db',
    action = function()
      require('dap').toggle_breakpoint()
    end,
    desc = 'Debug: Toggle Breakpoint',
  },
  {
    key = '<leader>dB',
    action = function()
      ---@type string|nil
      local condition = vim.fn.input('Breakpoint condition (optional): ')
      ---@type string|nil
      local hit_condition = vim.fn.input('Hit count (optional): ')

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
    key = '<leader>6',
    action = function()
      require('dap').run_last()
    end,
    desc = 'Debug: Rerun last.',
  },
  {
    key = '<leader>7',
    action = function()
      require('dap-view').toggle()
    end,
    desc = 'Debug: See last session result.',
  },
  {
    key = '<leader>dc',
    action = function()
      require('dap').clear_breakpoints()
    end,
    desc = 'Clear Breakpoints',
  },
  {
    key = '<leader>dr',
    action = function()
      require('dap').repl.toggle()
    end,
    desc = 'Toggle REPL',
  },
  {
    key = '<leader>dl',
    action = function()
      require('dap').list_breakpoints()
    end,
    desc = 'List breakpoints',
  },
  {
    key = '<leader>8',
    action = function()
      require('dap').step_back()
    end,
    desc = 'Step back',
  },
}

for _, kb in ipairs(keys) do
  vim.keymap.set('n', kb.key, kb.action, { desc = kb.desc })
end
