return {
  'danymat/neogen',
  cmd = 'Neogen',
  keys = {
    {
      '<leader>cn',
      function()
        require('neogen').generate()
      end,
      desc = 'Generate Annotations (Neogen)',
    },
  },
  opts = function()
    require('neogen').setup { snippet_engine = 'luasnip' }
  end,
}
