return {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Close right buffers' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Close left buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Close other buffers' },
      { '<leader>bp', '<Cmd>BufferLinePick<CR>', desc = 'Pick buffer' },
      { '<leader>bl', '<Cmd>BufferLineMoveNext<CR>', desc = 'Move current buffer right' },
      { '<leader>bh', '<Cmd>BufferLineMovePrev<CR>', desc = 'Move current buffer left' },
    },
    opts = function()
      return {
        highlights = require('catppuccin.groups.integrations.bufferline').get(),
        options = {
          indicator = { style = 'icon' },
          separator_style = 'think',
          buffer_close_icon = '',
          diagnostics = 'nvim_lsp',
        },
      }
    end,
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>b', group = 'Buffer' },
      },
    },
  },
}
