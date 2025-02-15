---@type LazyPluginSpec
return {
  'nmac427/guess-indent.nvim',
  enabled = false,
  event = {
    'VeryLazy',
    'BufReadPost',
    'BufNewFile',
  },
  opts = {},
}
