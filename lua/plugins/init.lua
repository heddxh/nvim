-- NOTE: If opts is set and config = true, Lazy will automatically run setup for this plugin.
-- If opts is set and config is a function,
-- should pass opts to this function and require the plugin manually.

---@module 'lazy'
---@type LazySpec
return {

  -- 昨日好きでも...
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {},
  },
  {
    'yorik1984/newpaper.nvim',
    priority = 1000,
    config = true,
    enabled = false,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000, opts = {
    transparent_background = true,
  } },
  -- 今日は飽きた

  {
    'xiyaowong/transparent.nvim',
    enabled = false,
    opts = {},
  },

  {
    'isak102/ghostty.nvim',
    lazy = true,
    opts = {},
  },

  {
    -- 'DanilaMihailov/beacon.nvim',
    dir = '/home/heddxh/workspace/code/beacon.nvim/',
    priority = 1000,
    opts = {},
  },

  {
    'nmac427/guess-indent.nvim',
    event = {
      'VeryLazy',
      'BufReadPost',
      'BufNewFile',
    },
    opts = {},
  },

  {
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
  },

  {
    'nat-418/boole.nvim',
    opts = {
      mappings = {
        increment = '<C-a>',
        decrement = '<C-x>',
      },
      -- User defined loops
      additions = {
        { 'Foo', 'Bar' },
        { 'tic', 'tac', 'toe' },
      },
      allow_caps_additions = {
        { 'enable', 'disable' },
        -- enable → disable
        -- Enable → Disable
        -- ENABLE → DISABLE
      },
    },
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      signs = {
        add = { text = '' },
        change = { text = '' },
        delete = { text = '' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts_extend = { 'spec' },
    opts = {
      preset = 'helix',
      icons = {
        mappings = true,
      },
    },
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        java = function() -- Organize imports on save
          vim.lsp.buf.code_action {
            ---@diagnostic disable-next-line
            context = { only = { 'source.organizeImports' } },
            apply = true,
          }
          return {}
        end, -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      highlight = { multiline = false },
    },
  },

  -- Mini.nvim: currently using files, surround, icons.
  {
    'echasnovski/mini.nvim',
    lazy = false,
    keys = {
      {
        '\\',
        function()
          MiniFiles.open()
        end,
      },
      {
        '<leader>\\',
        function()
          MiniFiles.open(vim.api.nvim_buf_get_name(0))
        end,
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
  },

  -- Auto toggle fcitx5
  {
    'lilydjwg/fcitx.vim',
    init = function()
      vim.g.fcitx5_remote = '/usr/bin/fcitx5-remote'
    end,
  },

  -- Autopairs
  ---@see https://github.com/windwp/nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
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
  },
  -- Translation
  ---@see https://github.com/uga-rosa/translate.nvim
  {
    'uga-rosa/translate.nvim',
    opts = {},
    cmd = 'Translate',
    keys = { { '<leader>t', '<Cmd>Translate zh-CN<CR>', desc = 'Translate to zh-CN', mode = 'v' } },
  },

  {
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
  },
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    dependencies = { 'onsails/lspkind.nvim' },
    keys = {
      { '<leader>o', '<Cmd>AerialToggle<CR>', desc = 'Open Aerial Outline' },
    },
    opts = {
      backends = { 'lsp', 'treesitter', 'markdown', 'asciidoc', 'man' },
      layout = {
        default_direction = 'float',
        max_width = 100,
      },
      float = {
        relative = 'editor',
      },
      close_automatic_events = { 'unfocus', 'switch_buffer', 'unsupported' },
      nerd_font = 'lspkind-nvim',
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
        'Field',
      },
    },
  },
}
