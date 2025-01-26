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

-- Fix some special buffers to its window
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lazy', 'mason' },
  callback = function()
    vim.wo.winfixbuf = true
  end,
})

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Alias for vim.opt
local o = vim.opt

o.number = true
o.relativenumber = false

-- How <C-o>, <C-i> works
o.jumpoptions = 'stack,view,clean'

-- Disable mouse
o.mouse = ''

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Show cmd in statusline
o.showcmdloc = 'statusline'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
-- :help signs
o.signcolumn = 'yes'

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- Vim session save
o.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

-- Default indent
local indent = 4
o.expandtab = (indent > 0)
o.tabstop = indent
o.softtabstop = indent
o.shiftwidth = indent

-- Match < and >
o.mps:append { '<:>' }

local map = vim.keymap.set
-- Remove search highlighting
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Disable arrow keys for moving
map('n', '<left>', '<Cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<Cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<Cmd>echo "Use h to move!!"<CR>')
map('n', '<down>', '<Cmd>echo "Use h to move!!"<CR>')
-- Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- Insert blank line
map('n', '<A-o>', 'o<Esc>', { desc = 'Insert a blank line below' })
map('n', '<A-O>', 'O<Esc>', { desc = 'Insert a blank line above' })

-- Set keymapping for <C-i> and Tab separately
map('n', '<C-i>', '<C-i>')
-- Using tab to jump across windows
map('n', '<Tab>', '<C-w><C-w>', { desc = 'Jump across windows' })

-- Move lines and keep visual
---@see https://github.com/kobbikobb/move-lines.nvim
map('v', '<C-j>', ":m '>+1<CR>gv=gv", { desc = 'Move lines up' })
map('v', '<C-k>', ":m '<-2<CR>gv=gv", { desc = 'Move lines down' })
map('v', '<C-h>', '<gv')
map('v', '<C-l>', '<gv')

-- Change indent
_G.SetIndent = function()
  local input_avail, input = pcall(vim.fn.input, 'Set indent value (>0 expandtab, <=0 noexpandtab): ')
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then
      return
    end
    vim.bo.expandtab = (indent > 0) -- local to buffer
    indent = math.abs(indent)
    vim.bo.tabstop = indent -- local to buffer
    vim.bo.softtabstop = indent -- local to buffer
    vim.bo.shiftwidth = indent -- local to buffer
    -- ui_notify(silent, ("indent=%d %s"):format(indent, vim.bo.expandtab and "expandtab" or "noexpandtab"))
    vim.cmd 'retab'
    vim.cmd 'normal gg=G' -- re-indent the whole file
  end
end
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(ev)
    if vim.api.nvim_get_option_value('buflisted', { buf = ev.buf }) ~= true then
      return
    end
    map('n', '<leader>ti', SetIndent, { desc = 'Change file indent', buffer = ev.buf })
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
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
require('lazy').setup {
  spec = {
    ---@see https://lazy.folke.io/usage/structuring#%EF%B8%8F-importing-specs-config--opts
    { import = 'plugins' },
    { import = 'language' },
  },
  pkg = {
    sources = { -- disallow lazy.lua spec in plugin itself
      'rockspec',
      'packspec',
    },
  },
  rocks = { enabled = false },
  install = { colorscheme = { 'tokyonight-day' } },
}
vim.cmd.colorscheme 'catppuccin'
