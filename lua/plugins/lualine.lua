-- $HOME/.config/nvim/lua/editor/statusline.lua
-- Status line
---@see https://github.com/nvim-lualine/lualine.nvim

-- Util function named in snake case, component function named in pascal case.

---@param hide_width number?
---@return boolean
local function is_wide_enough(hide_width)
  if not hide_width then
    hide_width = 120
  end
  return vim.o.columns >= hide_width
end

local function Indent()
  if vim.bo.expandtab then
    return vim.bo.shiftwidth .. ' Space'
  else
    return vim.bo.shiftwidth .. ' Tab'
  end
end

local function Showcmd()
  local cmd = vim.deepcopy(vim.api.nvim_eval_statusline('%S', {}).str)
  if vim.startswith(cmd, '~@') then -- Don't show weried ~@<fd> when leader pressed
    return '<leader>'
  end
  return cmd
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  opts = function(opts)
    local Filename = require('lualine.components.filename'):extend()
    function Filename:init(options)
      if is_wide_enough() then
        options.path = 1
      else
        options.path = 0
      end
      Filename.super:init(options)
    end
    function Filename:update_status()
      self.options.path = is_wide_enough() and 1 or 0
      local data = Filename.super.update_status(self)
      return data
    end

    return vim.tbl_deep_extend('force', opts, {
      extensions = { 'neo-tree' },
      options = {
        disabled_filetypes = {
          statusline = { 'snacks_dashboard' },
        },
        globalstatus = false,
        theme = 'catppuccin',
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
      },
      sections = {
        lualine_a = {
          'branch',
          {
            'diff',
            colored = true,
            diff_color = {
              added = { fg = 'Green' },
              modified = { fg = 'Blue' },
              removed = { fg = 'Red' },
            },
          },
        },
        lualine_b = { 'diagnostics' },
        lualine_c = { Filename },
        lualine_x = {
          {
            -- '%S'
            Showcmd,
          },
          { Indent },
          'filetype',
        },
        lualine_y = { 'location', 'progress' },
        lualine_z = { 'mode', {
          require('noice').api.status.mode.get,
          cond = require('noice').api.status.mode.has,
        } },
      },
    })
  end,
}
