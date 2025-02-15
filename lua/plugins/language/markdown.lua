-- Autolist
---@see https://github.com/gaoDean/autolist.nvim
---@source file:///home/heddxh/workspace/code/autolist.nvim
-- Markview
---@see https://github.com/OXY2DEV/markview.nvim

local support_ft = {
  'markdown',
  'tex',
  'plaintex',
  'norg',
}

return {
  {
    'OXY2DEV/markview.nvim',
    enabled = false,
    ft = support_ft,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local presets = require 'markview.presets'
      require('markview').setup {
        buf_ignore = { 'help', 'nofile' },
        headings = {
          enable = true,
          shift_width = 0,
          heading_1 = {
            style = 'label',
            sign = '󰌕 ',
            sign_hl = 'MarkviewHeading1Sign',
            align = 'center',
            padding_left = '╾──────╴ ',
            padding_right = ' ╶──────╼',
            icon = '',
            hl = 'MarkviewHeading1Sign',
          },
          heading_2 = { style = 'simple' },
          heading_3 = { style = 'simple' },
          heading_4 = { style = 'simple' },
          heading_5 = { style = 'simple' },
          heading_6 = { style = 'simple' },
          setext_1 = {
            style = 'decorated',
          },
        },
        list_items = {
          indent_size = 2,
          shift_width = 2,
        },
      }
    end,
  },
  ---@deprecated
  {
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = false,
    ft = support_ft,
    opts = {
      bullet = {
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        left_pad = 0,
        right_pad = 0,
        highlight = 'RenderMarkdownBullet',
      },
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        enabled = false,
        sign = false,
        icons = {},
        border_virtual = true,
        backgrounds = { '' },
      },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  {
    -- 'gaoDean/autolist.nvim',
    dir = '/home/heddxh/workspace/code/autolist.nvim',
    name = 'autolist',
    ft = support_ft,
    opts = {
      delete_empty = 'stay',
    },
    keys = function()
      return {
        { '<Tab>', '<Cmd>AutolistTab<CR>', mode = 'i', ft = support_ft },
        { '<S-Tab>', '<Cmd>AutolistShiftTab<CR>', mode = 'i', ft = support_ft },
        { '<CR>', '<CR><Cmd>AutolistNewBullet<CR>', mode = 'i', ft = support_ft },
        { 'o', 'o<Cmd>AutolistNewBullet<CR>', mode = 'n', ft = support_ft },
        { 'O', 'O<Cmd>AutolistNewBulletBefore<CR>', mode = 'n', ft = support_ft },
        { '<CR>', '<Cmd>AutolistToggleCheckbox<CR><CR>', mode = 'n', ft = support_ft },
        { '>>', '>><Cmd>AutolistRecalculate<CR>', mode = 'n', ft = support_ft },
        { '<<', '<<<Cmd>AutolistRecalculate<CR>', mode = 'n', ft = support_ft },
        { 'dd', 'dd<Cmd>AutolistRecalculate<CR>', mode = 'n', ft = support_ft },
        { 'd', 'd<Cmd>AutolistRecalculate<CR>', mode = 'v', ft = support_ft },
      }
    end,
  },
}
