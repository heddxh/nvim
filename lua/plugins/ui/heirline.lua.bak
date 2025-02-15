local function config()
  vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('heirline', {}),
    desc = 'Unlisting wipped or deleted buffer',
    callback = function()
      local bufhidden = vim.bo.bufhidden
      if vim.tbl_contains({ 'wipe', 'delete', 'hide' }, bufhidden) then
        vim.bo.buflisted = false
      end
    end,
  })

  local conditions = require 'heirline.conditions'
  local utils = require 'heirline.utils'

  local TablineFileName = {
    provider = function(self)
      -- self.filename will be defined later, just keep looking at the example!
      local filename = self.filename
      filename = filename == '' and '[No Name]' or vim.fn.fnamemodify(filename, ':t')
      return filename
    end,
    hl = function(self)
      return { bold = self.is_active or self.is_visible }
    end,
  }

  local TablineFileFlags = {
    {
      condition = function(self)
        return vim.api.nvim_get_option_value('modified', { buf = self.bufnr })
      end,
      provider = '[+]',
      hl = { fg = 'green' },
    },
    {
      condition = function(self)
        return not vim.api.nvim_get_option_value('modifiable', { buf = self.bufnr }) or vim.api.nvim_get_option_value('readonly', { buf = self.bufnr })
      end,
      provider = function(self)
        if vim.api.nvim_get_option_value('buftype', { buf = self.bufnr }) == 'terminal' then
          return '  '
        else
          return ''
        end
      end,
      hl = { fg = 'orange' },
    },
  }

  local TablineFileNameSpace = {
    provider = ' ',
    condition = function(self)
      return self.is_active
    end,
  }

  -- Here the filename block finally comes together
  local TablineFileName = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
      if self.is_active then
        return 'TablineSel'
      else
        return 'TabLine'
      end
    end,
    -- FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    -- TablineFileNameSpace,
    TablineFileName,
    TablineFileFlags,
    -- TablineFileNameSpace,
  }

  local TablinePicker = {
    condition = function(self)
      -- self._show_picker is toggle in keymapping
      -- Do not show picker for current/active buffer
      return self._show_picker and not self.is_active
    end,
    init = function(self)
      local bufname = vim.api.nvim_buf_get_name(self.bufnr)
      bufname = vim.fn.fnamemodify(bufname, ':t')
      local label = bufname:sub(1, 1)
      local i = 2
      while self._picker_labels[label] do
        if i > #bufname then
          break
        end
        label = bufname:sub(i, i)
        i = i + 1
      end
      self._picker_labels[label] = self.bufnr
      self.label = label
    end,
    provider = function(self)
      return '[' .. self.label .. ']'
    end,
    hl = { fg = utils.get_highlight('Visual').bg },
  }

  local TablineBufferWithSep = utils.surround({ '▌', '▐' }, function(self)
    if self.is_active then
      return 'gray'
    else
      return utils.get_highlight('TabLine').bg
    end
  end, { TablineFileName, TablinePicker })

  TablineBufferWithSep.hl = function(self)
    if self.is_active then
      return { bg = 'white' }
    else
      return { bg = utils.get_highlight('Tabline').bg }
    end
  end

  local function get_bufs()
    return vim.tbl_filter(function(bufnr)
      return vim.api.nvim_get_option_value('buflisted', { buf = bufnr })
    end, vim.api.nvim_list_bufs())
  end

  ---@deprecated
  -- Filter unnamed buffer and other
  local function get_filtered_bufs()
    local filtered_buf_name = {
      '[Location List]',
    }
    local bufs = get_bufs()
    return vim.tbl_filter(function(bufnr)
      if vim.api.nvim_buf_get_name(bufnr) == '' then
        return false
      elseif vim.tbl_contains(bufs, vim.api.nvim_buf_get_name(bufnr)) then
        return false
      else
        return true
      end
    end, bufs)
  end

  -- initialize the buflist cache
  local buflist_cache = {}

  -- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
  vim.api.nvim_create_autocmd({ 'VimEnter', 'UIEnter', 'BufAdd', 'BufDelete' }, {
    group = vim.api.nvim_create_augroup('Heirline', {}),
    desc = 'Updates the buflist_cache every time that buffers are added/removed',
    callback = function()
      vim.schedule(function()
        local buffers = get_bufs()
        for i, v in ipairs(buffers) do
          buflist_cache[i] = v
        end
        for i = #buffers + 1, #buflist_cache do
          buflist_cache[i] = nil
        end

        -- check how many buffers we have and set showtabline accordingly
        if #buflist_cache > 1 then
          vim.o.showtabline = 2 -- always
        elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
          vim.o.showtabline = 1 -- only when #tabpages > 1
        end
      end)
    end,
  })

  local TabLineOffset = {
    condition = function(self)
      local tree_name = 'neo-tree'

      local win = vim.api.nvim_tabpage_list_wins(0)[1]
      local bufnr = vim.api.nvim_win_get_buf(win)
      self.winid = win

      if vim.bo[bufnr].filetype == tree_name then
        self.title = tree_name
        return true
      end
    end,

    provider = function(self)
      local title = self.title
      local width = vim.api.nvim_win_get_width(self.winid)
      local pad = math.ceil((width - #title) / 2)
      return string.rep(' ', pad) .. title .. string.rep(' ', pad)
    end,

    hl = function(self)
      if vim.api.nvim_get_current_win() == self.winid then
        return 'TablineSel'
      else
        return 'Tabline'
      end
    end,
  }

  local BufferLineMain = utils.make_buflist(
    TablineBufferWithSep,
    { provider = '', hl = { fg = 'gray' } }, -- left truncation, optional (defaults to "<")
    { provider = '', hl = { fg = 'gray' } }, -- right trunctation, also optional (defaults to ...... yep, ">")
    -- out buf_func simply returns the buflist_cache
    function()
      return buflist_cache
    end,
    -- no cache, as we're handling everything ourselves
    false
  )

  local TabLine = { TabLineOffset, BufferLineMain }
  local winbar = {
    provider = function(_)
      local result = require('lspsaga.symbol.winbar').get_bar()
      if result == nil or result == '' then
        return ' 󰎇 Where have you been? Searching all along~'
      end
      return ' ' .. require('lspsaga.symbol.winbar').get_bar()
    end,
    hl = { bold = false },
  }
  local opts = {
    disable_winbar_cb = function(args)
      return conditions.buffer_matches({
        buftype = { 'nofile', 'prompt', 'help', 'quickfix', 'terminal' },
        filetype = { '^git.*', 'fugitive', 'Trouble', 'dashboard', 'alpha' },
      }, args.buf)
    end,
  }

  require('heirline').setup {
    -- tabline = TabLine,
    -- winbar = winbar,
    opts = opts,
  }
end

return {
  'rebelot/heirline.nvim',
  -- enabled = false,
  event = 'VeryLazy',
  config = config,
  keys = {
    -- {
    --   'gb',
    --   function()
    --     local tabline = require('heirline').tabline
    --     ---@diagnostic disable-next-line: undefined-field
    --     if not tabline._buflist then
    --       return
    --     end
    --     ---@diagnostic disable-next-line: undefined-field
    --     local buflist = tabline._buflist[1]
    --     buflist._picker_labels = {}
    --     buflist._show_picker = true
    --     vim.cmd.redrawtabline()
    --     local char = vim.fn.getcharstr()
    --     local bufnr = buflist._picker_labels[char]
    --     if bufnr then
    --       vim.api.nvim_win_set_buf(0, bufnr)
    --     end
    --     buflist._show_picker = false
    --     vim.cmd.redrawtabline()
    --   end,
    --   desc = 'Goto another buffer',
    -- },
  },
}
