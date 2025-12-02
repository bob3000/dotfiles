vim.api.nvim_create_user_command('OverseerRestartLast', function()
  local overseer = require 'overseer'
  local tasks = overseer.list_tasks { recent_first = true }
  if vim.tbl_isempty(tasks) then
    vim.notify('No tasks found', vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], 'restart')
  end
end, {})

return {
  {
    'stevearc/overseer.nvim',
    version = "*",
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerSaveBundle',
      'OverseerLoadBundle',
      'OverseerDeleteBundle',
      'OverseerRunCmd',
      'OverseerRun',
      'OverseerInfo',
      'OverseerBuild',
      'OverseerQuickAction',
      'OverseerTaskAction',
      'OverseerClearCache',
    },
    opts = {
      dap = false,
      task_list = {
        direction = "right",
        bindings = {
          ['<C-h>'] = false,
          ['<C-j>'] = false,
          ['<C-k>'] = false,
          ['<C-l>'] = false,
        },
      },
      form = {
        win_opts = {
          winblend = 0,
        },
      },
      confirm = {
        win_opts = {
          winblend = 0,
        },
      },
      task_win = {
        win_opts = {
          winblend = 0,
        },
      },
    },
    keys = {
      { '<leader>ow', '<cmd>OverseerToggle<cr>', desc = 'Task list' },
      { '<leader>oo', '<cmd>OverseerRun<cr>', desc = 'Run task' },
      { '<leader>oq', '<cmd>OverseerQuickAction<cr>', desc = 'Action recent task' },
      { '<leader>oi', '<cmd>OverseerInfo<cr>', desc = 'Overseer Info' },
      { '<leader>ob', '<cmd>OverseerBuild<cr>', desc = 'Task builder' },
      { '<leader>ot', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
      { '<leader>oc', '<cmd>OverseerClearCache<cr>', desc = 'Clear cache' },
      { '<leader>ol', '<cmd>OverseerRestartLast<cr>', desc = 'Overseer Last Task' },
    },
  },
}
