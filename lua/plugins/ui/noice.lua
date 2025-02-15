---@type LazyPluginSpec
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  ---@module 'noice'
  ---@type NoiceConfig
  opts = {
    presets = {
      command_palette = true,
      bottom_search = true,
    },
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
}
