---@type LazyPluginSpec
return {
  'Bekaboo/dropbar.nvim',
  event = 'VeryLazy',
  opts = function()
    local fallback = {
      get_symbols = function()
        return {
          require('dropbar.bar').dropbar_symbol_t:new {
            icon = '󰎇 ',
            icon_hl = 'Normal',
            name = 'Where have you been? Searching all along~',
            name_hl = 'Normal',
            on_click = nil,
          },
        }
      end,
    }
    return {
      bar = {
        sources = function()
          local sources = require 'dropbar.sources'
          return {
            require('dropbar.utils').source.fallback {
              sources.lsp,
              sources.treesitter,
              fallback,
            },
          }
        end,
      },
    }
  end,
}
