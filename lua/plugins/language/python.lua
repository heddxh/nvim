return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                -- typeCheckingMode = 'basic',
                diagnosticSeverityOverrides = {
                  reportUnusedVariable = false,
                },
              },
            },
          },
        },
        ruff = {
          autocmd = function(client)
            -- Only show hover from basedpyright.
            client.server_capabilities.hoverProvider = false
          end,
          mason = false,
          cmd_env = { RUFF_TRACE = 'error' },
          init_options = {
            settings = {
              logLevel = 'debug',
              lint = { select = { 'E', 'F' } },
            },
          },
        },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = { 'python' },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = function()
          vim.lsp.buf.code_action {
            context = { only = { 'source.organizeImports' } },
            apply = true,
          }
          return { 'ruff_format' }
        end,
      },
    },
  },
}
