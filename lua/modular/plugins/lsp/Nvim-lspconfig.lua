return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        dependencies = { 'mason-org/mason-registry' },
        enabled = function()
          return not is_nixos
        end,
        config = true,
      },
      {
        'williamboman/mason-lspconfig.nvim',
        enabled = function()
          return not is_nixos
        end,
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        enabled = function()
          return not is_nixos
        end,
      },
      { 'stevearc/conform.nvim' },
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = true },
    },

    config = function()
      local is_nixos = vim.fn.filereadable '/etc/NIXOS' == 1
      local lsp = require 'lspconfig'
      local diag = vim.diagnostic

      diag.config {
        virtual_text = false,
        signs = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      }
      require('lsp_lines').setup()

      local capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )

      local nix_servers = {
        bashls = { cmd = { vim.fn.exepath 'bash-language-server', 'start' } },
        clangd = { cmd = { vim.fn.exepath 'clangd' } },
        gopls = { cmd = { vim.fn.exepath 'gopls' } },
        pyright = { cmd = { vim.fn.exepath 'pyright-langserver' } },
        rust_analyzer = { cmd = { vim.fn.exepath 'rust-analyzer' } },
        lua_ls = { cmd = { vim.fn.exepath 'lua-language-server' } },
        nil_ls = { cmd = { vim.fn.exepath 'nil' } },
        taplo = { cmd = { vim.fn.exepath 'taplo' } },
        yamlls = { cmd = { vim.fn.exepath 'yaml-language-server' } },
        marksman = { cmd = { vim.fn.exepath 'marksman' } },
      }

      local function setup_server(server, config)
        config = vim.tbl_deep_extend('force', {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Общие обработчики для всех LSP
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
              vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
          end,
        }, config)

        lsp[server].setup(config)
      end

      if is_nixos then
        for server, config in pairs(nix_servers) do
          setup_server(server, config)
        end
      else
        require('mason').setup()
        require('mason-lspconfig').setup {
          automatic_installation = true,
          handlers = { setup_server },
        }
      end

      lsp.ruff.setup {
        cmd = is_nixos and { vim.fn.exepath 'ruff' } or nil,
        init_options = {
          settings = {
            executable = is_nixos and vim.fn.exepath 'ruff' or nil,
            args = { '--preview' },
          },
        },
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
