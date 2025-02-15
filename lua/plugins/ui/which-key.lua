---@type LazyPluginSpec
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function() require('which-key').show { global = false } end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    icons = {
      mappings = true,
    },
    spec = {
      { '<leader>c', group = 'Code' },
      { '<leader>b', group = 'Buffer' },
      { '<leader>f', group = 'Find Files' },
      { '<leader>s', group = 'Search Grep' },
      { '<leader>g', group = 'Git' },
      { '<leader>n', group = 'Notifiction' },
      { '<leader>t', group = 'Toggle' },
    },
  },
}
