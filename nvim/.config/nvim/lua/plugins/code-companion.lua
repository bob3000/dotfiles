---@class CodeCompanion.SystemPrompt.Context
---@field language string
---@field adapter CodeCompanion.HTTPAdapter|CodeCompanion.ACPAdapter
---@field date string
---@field nvim_version string
---@field os string the operating system that the user is using
---@field default_system_prompt string
---@field cwd string current working directory
---The closest parent directory that contains one of the following VCS markers:
--- - `.git`
--- - `.svn`
--- - `.hg`
---@field project_root? string the closest parent directory that contains a `.git` subdirectory.
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd [[cab cc CodeCompanion]]
return {
  {
    'olimorris/codecompanion.nvim',
    lazy = false,
    version = '*',
    depedendencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      {
        '<leader>cc',
        '<cmd>CodeCompanionChat Toggle<cr>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionChat',
      },
      {
        '<leader>cA',
        '<cmd>CodeCompanionChat Add<cr>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionChat Add',
      },
      {
        '<leader>ca',
        '<cmd>CodeCompanionActions<cr>',
        mode = { 'n', 'v' },
        desc = 'CodeCompanionActions',
      },
    },
    config = {
      interactions = {
        chat = {
          opts = {
            ---@param ctx CodeCompanion.SystemPrompt.Context
            ---@return string
            system_prompt = function(ctx)
              return ctx.default_system_prompt
                .. [[Additional context: Mildly adjust your way of
                communicating to the computer on the spaceship enterprise in
                the TV series Star Trek Next Generation. Your writing style
                shall be dry and computer like. Use technical language. When
                becoming aware that you committed an error or suffered from a
                hallucination start your response with "correction" or "compute
                error".
                
                Be brief and to the point unless I use phrases like `I'm
                learning` or `this is an exercise` which is a signal to you to
                respond more verbose explain in detail.
                
                Show references to relevant documentation pages when
                recommending specific configurations or settings. Make sure
                you're recommending up to data settings and practices. Don't
                recommend deprecated settings. Point out if I'm using
                deprecated or obsolete setting or diverging from common best
                practices. If you need to verify information or if you're
                lacking inforamtion you can use @{web_search} to obtain more
                information.
]]
            end,
          },
        },
      },
      strategies = {
        chat = {
          adapter = 'ollama',
        },
        inline = {
          adapter = 'ollama',
        },
        cmd = {
          adapter = 'ollama',
        },
        background = {
          adapter = 'ollama',
        },
      },
    },
  },
}
