return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  main = 'nvim-treesitter.configs',
  dependencies = 'nvim-treesitter/nvim-treesitter-textobjects',
  opts_extend = { 'ensure_installed' },
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'diff',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'regex',
      'fish',
      'toml',
      'xml',
      'json',
    },
    auto_install = true,
    -- Internal mods
    highlight = { enable = true },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = { enable = true },
    -- External mods
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = {
            query = '@function.outer',
            desc = 'Select Function Outside',
          },
          ['if'] = {
            query = '@function.inner',
            desc = 'Select Function Inside',
          },
          ['ac'] = { query = '@class.outer', desc = 'Select Class Outside' },
          ['ic'] = { query = '@class.inner', desc = 'Select Class Inside' },
          ['ap'] = {
            query = '@parameter.outer',
            desc = 'Select Parameter Outside',
          },
          ['ip'] = {
            query = '@parameter.inner',
            desc = 'Select Parameter Inside',
          },
          ['aa'] = {
            query = '@attribute.outer',
            desc = 'Select Attribute Outside',
          },
          ['ia'] = {
            query = '@attribute.inner',
            desc = 'Select Attribute Inside',
          },
        },
      },
    },
  },
}
