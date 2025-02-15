---@see https://github.com/nvim-lua/kickstart.nvim/blob/master/init.luaini
---@see https://learnxinyminutes.com/docs/lua/
-- Or see :help lua-guide. (or HTML version): https://neovim.io/doc/user/lua-guide.html

-- Adds the Lua loader using the byte-compilation cache
vim.loader.enable()

-- NOTE: since neovim has set termguicolors, highlight group will use gui attr.
local function hl(ns_id, name, val)
  if vim.tbl_isempty(val) then -- clear the hl group
    vim.api.nvim_set_hl(ns_id, name, {})
    return
  end
  local old = vim.api.nvim_get_hl(ns_id, { name = name })
  local new = vim.tbl_extend('force', old, val)
  vim.api.nvim_set_hl(ns_id, name, new)
end
-- NOTE: tweak colorscheme, using autocmd to wait until colorscheme loaded
-- Since most colorscheme will run `hi clear`
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    -- hl(0, 'TelescopeMatching', { link = 'Constant' })
    -- hl(0, 'WinSeparator', { link = 'Folded' })
    -- hl(0, 'TabLineFill', { bg = '#bcbcbc' })
    -- hl(0, 'TabLine', { bg = '#bcbcbc' })
    -- hl(0, 'Todo', {}) -- clean the todo highlight for todo-comment plugin
    -- Mini icons
    -- hl(0, 'MiniIconsAzure', {})
    -- hl(0, 'MiniIconsBlue', {})
    -- hl(0, 'MiniIconsCyan', {})
    -- hl(0, 'MiniIconsGreen', {})
    -- hl(0, 'MiniIconsGrey', {})
    -- hl(0, 'MiniIconsOrange', {})
    -- hl(0, 'MiniIconsPurple', {})
    -- hl(0, 'MiniIconsRed', {})
    -- hl(0, 'MiniIconsYellow', {})
    -- Diagnotics
    -- hl(0, 'DiagnosticUnderlineError', { underline = false, underdotted = true })
    -- hl(0, 'DiagnosticUnderlineWarn', { underline = false, underdotted = true })
    -- hl(0, 'DiagnosticUnderlineInfo', { underline = false, underdotted = true })
    -- hl(0, 'DiagnosticUnderlineHint', { underline = false, underdotted = true })
    -- hl(0, 'DiagnosticUnderlineOk', { underline = false, underdotted = true })
  end,
})

require 'init'

vim.cmd.colorscheme 'catppuccin'
