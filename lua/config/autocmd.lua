-- Change indent
_G.SetIndent = function()
  local input_avail, input =
    pcall(vim.fn.input, 'Set indent value (>0 expandtab, <=0 noexpandtab): ')
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then return end
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
    vim.keymap.set(
      'n',
      '<leader>ti',
      SetIndent,
      { desc = 'Change file indent', buffer = ev.buf }
    )
  end,
})

-- Fix some special buffers to its window
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lazy', 'mason' },
  callback = function() vim.wo.winfixbuf = true end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})
