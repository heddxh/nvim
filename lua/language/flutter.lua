return {
  {
    'nvim-flutter/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    ft = { 'dart' },
    init = function()
      vim.api.nvim_create_autocmd({ 'LspAttach' }, {
        group = vim.api.nvim_create_augroup('flutter', {}),
        pattern = '*.dart',
        callback = function(ev)
          local o = vim.bo[ev.buf]
          local indent = 2
          o.expandtab = (indent > 0)
          o.tabstop = indent
          o.softtabstop = indent
          o.shiftwidth = indent

          -- Flutter outline key mapping
          vim.keymap.set('n', '<leader>\\', '<cmd>FlutterOutlineToggle<CR>', { desc = 'Toggle flutter outline', buffer = ev.buf })
        end,
        desc = 'Autocmd for flutter and dart',
      })
      vim.api.nvim_create_autocmd({ 'BufRead' }, {
        pattern = '*/pubspec.yaml',
        callback = function()
          vim.notify 'Load flutter tools'
          require('lazy').load {
            plugins = { 'flutter-tools.nvim' },
          }
        end,
        desc = 'Autocmd for flutter and dart',
      })
    end,
    opts = function()
      return {
        fvm = true,
        widget_guides = { enabled = true },
        lsp = {
          color = { enabled = true },
          capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities() or {}),
          -- settings = { completeFunctionCalls = false }, -- dart using zero index in snippet placeholder, which is only supported by luasnip
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'dart' },
      -- Disable treesitter-text-object-select for dart , see: https://github.com/nvim-treesitter/nvim-treesitter/issues/2126
      textobjects = { select = { disable = { 'dart' } } },
    },
  },
  {
    'dart-lang/dart-vim-plugin',
    enabled = false,
    config = function()
      vim.g.dart_format_on_save = false
    end,
  },
}
