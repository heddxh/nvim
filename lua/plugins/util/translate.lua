---@type LazyPluginSpec
return {
  'uga-rosa/translate.nvim',
  opts = {},
  cmd = 'Translate',
  keys = {
    {
      '<leader>t',
      '<Cmd>Translate zh-CN<CR>',
      desc = 'Translate to zh-CN',
      mode = 'v',
    },
  },
}
