vim.env.LAZY_STDPATH = '.repro'
load(vim.fn.system 'curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua')()

require('lazy.minit').repro {
  spec = {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      indicator = { style = 'underline' },
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level)
        local icon = level:match 'error' and ' ' or ' '
        return ' ' .. count
      end,
    },
  },
}
