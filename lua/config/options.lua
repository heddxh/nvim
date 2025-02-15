local o = vim.opt

-- Interface
vim.o.number = true
vim.o.relativenumber = false
vim.o.numberwidth = 3
vim.o.signcolumn = 'yes:1'
vim.o.statuscolumn = '%l %s'

-- How <C-o>, <C-i> works
o.jumpoptions = 'stack,view,clean'

-- Disable mouse
-- o.mouse = ''
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() o.clipboard = 'unnamedplus' end)

-- Enable break inaent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

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
o.sessionoptions = {
  'buffers',
  'curdir',
  'tabpages',
  'winsize',
  'help',
  'globals',
  'skiprtp',
  'folds',
}

-- Default indent
local indent = 4
o.expandtab = (indent > 0)
o.tabstop = indent
o.softtabstop = indent
o.shiftwidth = indent

-- Match < and >
o.mps:append { '<:>' }
