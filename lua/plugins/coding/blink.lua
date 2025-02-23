-- blink.cmp
-- auto completion
-- https://github.com/Saghen/blink.cmp
---@type LazyPluginSpec[]
return {
  {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        opts = function()
          return {
            ext_opts = {
              [require('luasnip.util.types').choiceNode] = {
                active = {
                  virt_text = { { '', 'Operator' } },
                  virt_text_pos = 'inline',
                },
                unvisited = {
                  virt_text = { { '', 'Comment' } },
                  virt_text_pos = 'inline',
                },
              },
              [require('luasnip.util.types').insertNode] = {
                active = {
                  virt_text = { { '', 'Keyword' } },
                  virt_text_pos = 'inline',
                },
                unvisited = {
                  virt_text = { { '', 'Comment' } },
                  virt_text_pos = 'inline',
                },
              },
            },
          }
        end,
      },
    },
    build = 'cargo build --release',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- Using luasnip since native snippet engine treat zero index placeholder wrongly.
      -- See: https://github.com/neovim/neovim/issues/29251
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' },
        providers = {
          lsp = { fallbacks = { 'lazydev' } },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
          },
        },
      },
      keymap = {
        ['<C-space>'] = { 'show', 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-k>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-j>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },
      cmdline = {
        keymap = {
          ['<Tab>'] = { 'show_and_insert', 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
        },
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = function(ctx) return ctx.mode == 'cmdline' end,
          },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = 'rounded',
          draw = {
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
              { 'source_name' },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
          window = { border = 'rounded', winblend = vim.o.pumblend },
        },
      },
      signature = { enabled = false }, -- auto show signature using noice
    },
  },
  {
    'catppuccin/nvim',
    opts = { integrations = { blink_cmp = true } },
  },
}
