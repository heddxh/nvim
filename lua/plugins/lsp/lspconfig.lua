---@type LazyPluginSpec
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  dependencies = {
    -- 'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    -- 'WhoIsSethDaniel/mason-tool-installer.nvim',
    'b0o/SchemaStore.nvim',
    {
      'j-hui/fidget.nvim',
      enabled = false,
      opts = {
        progress = {
          suppress_on_insert = true,
        },
        notification = {
          window = { align = 'avoid_cursor' },
        },
      },
    },
  },
  -- Manually setup Lspconfig in `config`, here we just store static configuration, and pass it to `config`.
  -- NOTE: configuration under language/ may be merged into it.
  ---@source: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
  opts = {
    ---@type vim.diagnostic.Opts
    diagnostics = {
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      virtual_text = false, -- using tiny-inline-diagnostic to show diagnostics
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
          [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
          [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
          [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
        },
      },
    },
    inlay_hint = { enable = true },
    codelens = { enable = true },
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
    servers = {
      -- Lua
      lua_ls = {
        -- Function will run in LspAttach autocmd for this server, see below.
        autocmd = {},
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
            codeLens = {
              enable = true,
            },
            completion = {
              callSnippet = 'Replace',
            },
            doc = {
              privateName = { '^_' },
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = true,
              semicolon = true,
              arrayIndex = true,
            },
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            -- schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      lemminx = {
        settings = {
          -- https://github.com/eclipse-lemminx/lemminx/issues/1287
          xml = { catalogs = { vim.fn.stdpath 'data' .. '/xml/catalog.xml' } },
        },
      },
    },
  },
  config = function(_, opts)
    vim.diagnostic.config(opts.diagnostics)

    local augroup = vim.api.nvim_create_augroup('lsp', { clear = true })
    local servers = opts.servers

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('blink.cmp').get_lsp_capabilities() or {},
      opts.capabilities or {}
    )

    local function setup(server)
      local server_opts = vim.tbl_deep_extend(
        'force',
        { capabilities = capabilities },
        servers[server] or {} -- override default capabilities
      )
      if server_opts.enabled == false then -- disable the server
        return
      else
        if type(server_opts.autocmd) == 'function' then
          vim.api.nvim_create_autocmd('LspAttach', {
            group = augroup,
            callback = function(event)
              local client = vim.lsp.get_client_by_id(event.data.client_id)
              if not client or client.name ~= server then return end
              server_opts.autocmd(client)
            end,
          })
        end
      end
      require('lspconfig')[server].setup(server_opts)
    end

    local ensure_installed = {}
    for server, server_opts in pairs(servers) do
      if server_opts then
        if server_opts.enabled ~= false then
          -- Run manual setup for mason=false
          if server_opts.mason == false then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end
    end

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      automatic_installation = true,
      handlers = { setup }, -- :help mason-lspconfig-automatic-server-setup
    }

    -- LSP attached buffer settings
    vim.api.nvim_create_autocmd('LspAttach', {
      group = augroup,
      callback = function(event)
        -- :help lsp-defaults
        -- Remove them all.
        -- Only keep:
        -- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
        local d = function(lhs, mode)
          mode = mode or 'n'
          pcall(vim.keymap.del, mode, lhs) -- avoid duplicated deleting
        end
        d 'grn'
        d 'grr'
        d 'gri'
        d 'gO'
        d('gra', { 'n', 'v' })

        local map = function(keys, func, desc, mode)
          -- Key mapping
          mode = mode or 'n'
          vim.keymap.set(
            mode,
            keys,
            func,
            { buffer = event.buf, desc = 'LSP: ' .. desc }
          )
        end
        map(
          'gd',
          function() Snacks.picker.lsp_definitions() end,
          'Goto Definition'
        )
        map(
          'gr',
          function() Snacks.picker.lsp_references() end,
          'Goto References'
        )
        map(
          'gi',
          function() Snacks.picker.lsp_implementations() end,
          'Goto Implementation'
        )
        map(
          'gt',
          function() Snacks.picker.lsp_type_definitions() end,
          'Goto Type Defination'
        )
        map(
          '<leader>ss',
          function() Snacks.picker.lsp_symbols() end,
          'Search Lsp Symbols'
        )
        map(
          'gD',
          function() Snacks.picker.lsp_declarations() end,
          'Goto Declaration'
        )
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Actions')
        map('<C-s>', vim.lsp.buf.signature_help, 'Signature Help')
        map('<leader>cr', vim.lsp.buf.rename, 'Symbol Rename')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- Enable inlay hint by default.
        if
          client
          and client:supports_method(
            vim.lsp.protocol.Methods.textDocument_inlayHint
          )
        then
          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end
      end,
    })
  end,
}
