local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

---@see https://lazy.folke.io/usage/structuring
-- NOTE: Since I have both plugin specs and regular lua module under `lua/` directories,
-- using `import` for those directories is not available.
-- BTW, lazy doesn't add `.local/share/nvim/lazy` to `rtp`, but add per plugin path,
-- so directly require plugins outside lazy spec in my lua module is also unavailable.
-- NOTE: If opts is set and config = true, Lazy will automatically run setup for this plugin.
-- If opts is set and config is a function,
-- should pass opts to this function and require the plugin manually.

require('lazy').setup {
  spec = 'plugins',
  pkg = {
    sources = { -- disallow lazy.lua spec in plugin itself
      'rockspec',
      'packspec',
    },
  },
  rocks = { enabled = false },
  -- install = { colorscheme = { 'default' } },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        -- 'matchit',
        -- 'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}
