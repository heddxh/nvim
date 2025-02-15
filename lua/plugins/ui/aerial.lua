---@type LazyPluginSpec
return {
  'stevearc/aerial.nvim',
  event = 'VeryLazy',
  dependencies = { 'onsails/lspkind.nvim' },
  keys = {
    { '<leader>o', '<Cmd>AerialToggle<CR>', desc = 'Open Aerial Outline' },
  },
  opts = {
    backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },
    layout = {
      default_direction = 'float',
      max_width = 100,
    },
    float = {
      relative = 'editor',
    },
    close_automatic_events = { 'unfocus', 'switch_buffer', 'unsupported' },
    nerd_font = 'lspkind-nvim',
    filter_kind = {
      'Class',
      'Constructor',
      'Enum',
      'Function',
      'Interface',
      'Module',
      'Method',
      'Struct',
      'Field',
    },
  },
}
