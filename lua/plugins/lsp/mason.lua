---@type LazyPluginSpec
return {
  'williamboman/mason.nvim',
  cmd = 'Mason',
  build = ':MasonUpdate',
  -- https://github.com/folke/lazy.nvim/blob/7e6c863bc7563efbdd757a310d17ebc95166cef3/CHANGELOG.md?plain=1#L472
  opts_extend = { 'ensure_installed' },
  opts = {
    ensure_installed = {
      'stylua',
      -- 'shfmt',
    },
    ui = {
      border = 'none',
      keymaps = { toggle_help = '?' },
    },
  },
}
