---@type LazyPluginSpec
return {
  'echasnovski/mini.nvim',
  lazy = false,
  keys = {
    {
      '\\',
      function() MiniFiles.open() end,
      desc = 'MiniFiles(cwd)',
    },
    {
      '<leader>\\',
      function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end,
      desc = 'MiniFiles(current file)',
    },
  },
  config = function()
    require('mini.surround').setup()
    require('mini.icons').setup {
      extension = {
        ['h'] = { glyph = '' },
      },
    }
    MiniIcons.mock_nvim_web_devicons()
    require('mini.files').setup {
      windows = { preview = true, width_preview = 40 },
    }
  end,
}
