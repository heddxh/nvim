---@type LazyPluginSpec
return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    preset = 'simple',
    options = {
      show_source = true,
      multilines = true,
      show_all_diags_on_cursorline = true,
    },
  },
}
