---@type LazyPluginSpec
return {
  'lilydjwg/fcitx.vim',
  init = function() vim.g.fcitx5_remote = '/usr/bin/fcitx5-remote' end,
}
