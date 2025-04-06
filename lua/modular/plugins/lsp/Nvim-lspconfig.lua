return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = true,
      },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
      { 'zapling/mason-conform.nvim' },
    },

    config = function()
      -- .env to env filetype
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = '.env',
        callback = function()
          vim.bo.filetype = 'env'
        end,
      })

      vim.diagnostic.config {
        virtual_text = true,
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup(
          'kickstart-lsp-attach',
          { clear = true }
        ),

        callback = function(event)
          -- Disable LSP for .env files
          local filename = vim.api.nvim_buf_get_name(event.buf)
          if vim.fn.fnamemodify(filename, ':t') == '.env' then
            local clients = vim.lsp.get_clients { bufnr = event.buf }
            for _, client in ipairs(clients) do
              vim.lsp.stop_client(client.id)
            end
            return
          end

          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(
              mode,
              keys,
              func,
              { buffer = event.buf, desc = 'LSP: ' .. desc }
            )
          end

          -- Mappings for LSP features
          map(
            'gd',
            require('telescope.builtin').lsp_definitions,
            'Goto Definition'
          )

          map(
            'gr',
            require('telescope.builtin').lsp_references,
            'Goto References'
          )

          map(
            'gI',
            require('telescope.builtin').lsp_implementations,
            'Goto Implementation'
          )

          map(
            '<leader>lD',
            require('telescope.builtin').lsp_type_definitions,
            'Type Definition'
          )

          map('<leader>lr', vim.lsp.buf.rename, 'Rename')

          map(
            '<leader>lc',
            vim.lsp.buf.code_action,
            'Code Action',
            { 'n', 'x' }
          )

          map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if
            client
            and client.supports_method(
              vim.lsp.protocol.Methods.textDocument_documentHighlight
            )
          then
            local highlight_augroup = vim.api.nvim_create_augroup(
              'kickstart-lsp-highlight',
              { clear = false }
            )

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          if
            client
            and client.supports_method(
              vim.lsp.protocol.Methods.textDocument_inlayHint
            )
          then
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
              bufnr = event.buf,
            })

            map('<leader>lh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
                bufnr = event.buf,
              })
            end, 'Toggle Inlay Hints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        'force',
        capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      local servers = {
        bashls = {
          filetypes = { 'sh', 'bash' },
        },
        html = {
          filetypes = { 'html', 'twig', 'hbs' },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              completion = { callSnippet = 'Replace' },
              telemetry = { enable = false },
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
              diagnostics = {
                enable = true,
                globals = { 'vim' }, -- Ignore 'vim' as undefined global
                -- disable = { 'missing-fields' },
              },
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
              },
            },
          },
        },
        ruff = {
          -- Notes on code actions: https://github.com/astral-sh/ruff-lsp/issues/119#issuecomment-1595628355
          -- Get isort like behavior: https://github.com/astral-sh/ruff/issues/8926#issuecomment-1834048218
          commands = {
            RuffAutofix = {
              function()
                vim.lsp.buf.execute_command {
                  command = 'ruff.applyAutofix',
                  arguments = {
                    { uri = vim.uri_from_bufnr(0) },
                  },
                }
              end,
              description = 'Ruff: Fix all auto-fixable problems',
            },
            RuffOrganizeImports = {
              function()
                vim.lsp.buf.execute_command {
                  command = 'ruff.applyOrganizeImports',
                  arguments = {
                    { uri = vim.uri_from_bufnr(0) },
                  },
                }
              end,
              description = 'Ruff: Format imports',
            },
          },
        },
      }

      -- Extend `ensure_installed` with your list of servers and tools
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'bashls',
        'clangd',
        'cssls',
        'taplo',
        'dockerls',
        'docker_compose_language_service',
        'gopls',
        'html',
        'jsonls',
        'kotlin_language_server',
        'lua_ls',
        'marksman',
        'pylsp',
        'ruff',
        'rust_analyzer',
        'sqlls',
        'tailwindcss',
        'ts_ls',
        'stylua',
        'yamlls',
        'shellcheck',
      })

      local lsp = require 'lspconfig'

      lsp.marksman.setup {
        cmd = { 'marksman', 'server' },
        filetypes = { 'markdown' },
        root_dir = require('lspconfig.util').root_pattern('.git', '.'),
        settings = {
          marksman = {},
        },
      }

      lsp.ts_ls.setup {
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
      }

      lsp.cssls.setup {
        filetypes = { 'css', 'scss', 'less' },
        single_file_support = false,
        settings = {},
      }

      -- Mason
      require('mason').setup()
      require('mason-conform').setup {
        ignore_install = {},
      }
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              'force',
              {},
              capabilities,
              server.capabilities or {}
            )
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
