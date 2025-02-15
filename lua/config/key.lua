vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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
