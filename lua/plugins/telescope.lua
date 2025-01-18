-- Find, preview and goto
---@see https://github.com/nvim-telescope/telescope.nvim

return {
  'nvim-telescope/telescope.nvim',
  enabled = false,
  version = false, -- Just follow HEAD
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        aerial = {
          format_symbol = function(symbol_path, filetype)
            if filetype == 'json' or filetype == 'yaml' then
              return table.concat(symbol_path, '.')
            else
              return symbol_path[#symbol_path]
            end
          end,
          -- Available modes: symbols, lines, both
          show_columns = 'both',
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require 'telescope.builtin'
    local map = vim.keymap.set
    map('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
    map('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
    map('n', '<leader>sf', '<cmd>Telescope find_files hidden=true<CR>', { desc = 'Search Files' })
    map('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
    map('n', '<leader>sw', builtin.grep_string, { desc = 'Search current Word' })
    map('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
    map('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
    map('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
    map('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
    map('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
    map('n', '<leader>so', require('telescope').extensions.aerial.aerial, { desc = 'Search Outline/Symbols' })
    --
    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'Search in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Search Neovim files' })
  end,
}
