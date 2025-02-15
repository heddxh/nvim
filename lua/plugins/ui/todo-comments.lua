---@type LazyPluginSpec
return {
  'folke/todo-comments.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    highlight = { multiline = false },
  },
  keys = {
    {
      '<leader>st',
      ---@diagnostic disable-next-line: undefined-field
      function() Snacks.picker.todo_comments() end,
      desc = 'Todo',
    },
  },
}
