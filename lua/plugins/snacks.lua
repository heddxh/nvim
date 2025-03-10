---@module 'snacks'
---@type LazyPluginSpec[]
return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        sections = {
          {
            section = 'terminal',
            cmd = 'chafa $HOME/.config/nvim/static/Yanami.png --clear -f symbols --symbols solid --align="top,center" ',
            height = 22,
            ttl = 300,
          },
          {
            {
              text = {
                { '  LOVE 2000  ', align = 'center', padding = 1 },
              },
            },
            { text = { { '󰙣          󰙡', align = 'center' } } },
          },
          {
            section = 'keys',
            pane = 2,
          },
          {
            section = 'recent_files',
            pane = 2,
          },
        },
      },
      indent = {},
      quickfile = {},
      bigfile = {},
      notifier = {
        enabled = true,
        timeout = 3500,
        style = 'fancy',
      },
      scroll = {},
      words = {},
      toggle = {},
      picker = {},
      image = {},
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      -- Notifications
      {
        '<leader>nh',
        function() Snacks.notifier.show_history() end,
        desc = 'Show Notification History',
      },
      {
        '<leader>nu',
        function() Snacks.notifier.hide() end,
        desc = 'Dismiss All Notifications',
      },
      -- Buffer remove
      {
        '<leader>bd',
        function() Snacks.bufdelete() end,
        desc = 'Delete Buffer',
      },
      -- File rename
      {
        '<leader>cR',
        function() Snacks.rename.rename_file() end,
        desc = 'Rename File',
      },
      -- Reference jump
      {
        '<C-]>',
        function() Snacks.words.jump(vim.v.count1) end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '<c-[>',
        function() Snacks.words.jump(-vim.v.count1) end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      -- Scratch
      {
        '<leader>.',
        function() Snacks.scratch() end,
        desc = 'Scratch Buffer',
      },
      {
        '<leader>fs',
        function() Snacks.scratch.select() end,
        desc = 'Find Scratch Buffer',
      },

      -- Picker
      {
        '<leader><space>',
        function() Snacks.picker.smart() end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>,',
        function() Snacks.picker.buffers { nofile = true } end,
        desc = 'Buffers',
      },
      {
        '<leader>/',
        function() Snacks.picker.grep() end,
        desc = 'Grep',
      },
      {
        '<leader>:',
        function() Snacks.picker.command_history() end,
        desc = 'Command History',
      },
      {
        '<leader>fb',
        function() Snacks.picker.buffers() end,
        desc = 'Find Buffers',
      },
      {
        '<leader>fc',
        function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end,
        desc = 'Find Config File',
      },
      {
        '<leader>ff',
        function() Snacks.picker.files() end,
        desc = 'Find Files',
      },
      {
        '<leader>fg',
        function() Snacks.picker.git_files() end,
        desc = 'Find Git Files',
      },
      {
        '<leader>fr',
        function() Snacks.picker.recent() end,
        desc = 'Find Recent',
      },
      -- Git
      {
        '<leader>gO',
        function() Snacks.gitbrowse.open() end,
        desc = 'Open in browser',
      },
      {
        '<leader>gl',
        function() Snacks.picker.git_log() end,
        desc = 'Git Log',
      },
      {
        '<leader>gs',
        function() Snacks.picker.git_status() end,
        desc = 'Git Status',
      },
      {
        '<leader>gb',
        function() Snacks.picker.git_log_line() end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gd',
        function() Snacks.picker.git_diff() end,
        desc = 'Git Diff',
      },
      {
        '<leader>gf',
        function() Snacks.picker.git_log_file() end,
        desc = 'Lazygit',
      },
      {
        '<leader>gg',
        function() Snacks.lazygit() end,
        desc = 'Lazygit',
      },
      -- Grep
      {
        '<leader>sp',
        function() Snacks.picker.pickers() end,
        desc = 'Snack Pickers',
      },
      {
        '<leader>sb',
        function() Snacks.picker.lines() end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sB',
        function() Snacks.picker.grep_buffers() end,
        desc = 'Grep Open Buffers',
      },
      {
        '<leader>sg',
        function() Snacks.picker.grep() end,
        desc = 'Grep',
      },
      {
        '<leader>sw',
        function() Snacks.picker.grep_word() end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>s"',
        function() Snacks.picker.registers() end,
        desc = 'Registers',
      },
      {
        '<leader>sa',
        function() Snacks.picker.autocmds() end,
        desc = 'Autocmds',
      },
      {
        '<leader>sc',
        function() Snacks.picker.command_history() end,
        desc = 'Command History',
      },
      {
        '<leader>sC',
        function() Snacks.picker.commands() end,
        desc = 'Commands',
      },
      {
        '<leader>sD',
        function() Snacks.picker.diagnostics() end,
        desc = 'Diagnostics Current Buffer',
      },
      {
        '<leader>sd',
        function() Snacks.picker.diagnostics_buffer() end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sh',
        function() Snacks.picker.help() end,
        desc = 'Help Pages',
      },
      {
        '<leader>sH',
        function() Snacks.picker.highlights() end,
        desc = 'Highlights',
      },
      {
        '<leader>sj',
        function() Snacks.picker.jumps() end,
        desc = 'Jumps',
      },
      {
        '<leader>sk',
        function() Snacks.picker.keymaps() end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function() Snacks.picker.loclist() end,
        desc = 'Location List',
      },
      {
        '<leader>sM',
        function() Snacks.picker.man() end,
        desc = 'Man Pages',
      },
      {
        '<leader>sm',
        function() Snacks.picker.marks() end,
        desc = 'Marks',
      },
      {
        '<leader>sR',
        function() Snacks.picker.resume() end,
        desc = 'Resume',
      },
      {
        '<leader>sq',
        function() Snacks.picker.qflist() end,
        desc = 'Quickfix List',
      },
      {
        '<leader>tC',
        function() Snacks.picker.colorschemes() end,
        desc = 'Toggle Colorschemes',
      },
      -- {
      --   '<leader>qp',
      --   function()
      --     Snacks.picker.projects()
      --   end,
      --   desc = 'Projects',
      -- },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...) Snacks.debug.inspect(...) end
          _G.bt = function() Snacks.debug.backtrace() end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>ts'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>tw'
          Snacks.toggle
            .option('relativenumber', { name = 'Relative Number' })
            :map '<leader>tL'
          Snacks.toggle.diagnostics():map '<leader>td'
          Snacks.toggle.line_number():map '<leader>tl'
          Snacks.toggle
            .option('conceallevel', {
              off = 0,
              on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
              name = 'Conceallevel',
            })
            :map '<leader>tc'
          Snacks.toggle.treesitter():map '<leader>tT'
          Snacks.toggle
            .option(
              'background',
              { off = 'light', on = 'dark', name = 'Dark Background' }
            )
            :map '<leader>tb'
          Snacks.toggle.inlay_hints():map '<leader>th'
          Snacks.toggle.indent():map '<leader>tg'
          Snacks.toggle.dim():map '<leader>tD'
        end,
      })
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesActionRename',
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end,
  },
  {
    'catppuccin/nvim',
    opts = {
      integrations = {
        snacks = {
          enabled = true,
          indent_scope_color = 'flamingo',
        },
      },
    },
  },
}
