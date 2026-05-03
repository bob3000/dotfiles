return {
  {
    'stevearc/overseer.nvim',
    version = '*',
    cmd = {
      'OverseerOpen',
      'OverseerClose',
      'OverseerToggle',
      'OverseerShell',
      'OverseerRun',
      'OverseerRestartLast',
    },
    opts = {
      task_list = {
        -- Default direction. Can be "left", "right", or "bottom"
        direction = 'right',
      },
    },
    config = function()
      vim.api.nvim_create_user_command('OverseerRestartLast', function()
        local overseer = require 'overseer'
        local task_list = require 'overseer.task_list'
        local tasks = overseer.list_tasks {
          status = {
            overseer.STATUS.SUCCESS,
            overseer.STATUS.FAILURE,
            overseer.STATUS.CANCELED,
          },
          sort = task_list.sort_finished_recently,
        }
        if vim.tbl_isempty(tasks) then
          vim.notify('No tasks found', vim.log.levels.WARN)
        else
          local most_recent = tasks[1]
          overseer.run_action(most_recent, 'restart')
        end
      end, {})
    end,
    keys = {
      { '<leader>ow', '<cmd>OverseerToggle<cr>', desc = 'Task list' },
      { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
      { '<leader>ot', '<cmd>OverseerTaskAction<cr>', desc = 'Task action' },
      { '<leader>oo', '<cmd>OverseerRestartLast<cr>', desc = 'Overseer Last Task' },
    },
  },
}
