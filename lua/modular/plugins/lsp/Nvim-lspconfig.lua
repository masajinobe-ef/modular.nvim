return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'https://git.sr.ht/~whynothugo/lsp_lines.nvim', config = true },
    },

    config = function()
      local is_nixos = vim.fn.filereadable '/etc/NIXOS' == 1
      local lsp = require 'lspconfig'
      local diag = vim.diagnostic

      diag.config {
        virtual_text = true, -- Inline text
        signs = true, -- Gutter signs
        underline = true, -- Highlight problematic code
        update_in_insert = false,
        severity_sort = true,
      }

      require('lsp_lines').setup()

      -- LSP capabilities setup
      local capabilities = vim.tbl_deep_extend(
        'force',
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- Nix language servers
      local nix_servers = {
        bashls = { cmd = { vim.fn.exepath 'bash-language-server', 'start' } }, -- bash
        clangd = { cmd = { vim.fn.exepath 'clangd' } }, -- C
        gopls = { cmd = { vim.fn.exepath 'gopls' } }, -- go
        lua_ls = { cmd = { vim.fn.exepath 'lua-language-server' } }, -- lua
        nil_ls = { cmd = { vim.fn.exepath 'nil' } }, -- nix
        taplo = { cmd = { vim.fn.exepath 'taplo' } }, -- toml
        yamlls = { cmd = { vim.fn.exepath 'yaml-language-server' } }, -- yaml
        marksman = { cmd = { vim.fn.exepath 'marksman' } }, -- markdown

        -- Python
        ruff = { cmd = { vim.fn.exepath 'ruff', 'server' } }, -- Python LSP
        pyright = { cmd = { vim.fn.exepath 'pyright' } }, -- Type checker
      }

      -- Init servers func
      local function setup_server(server, config)
        config = vim.tbl_deep_extend('force', {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
              vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
          end,
        }, config)

        lsp[server].setup(config)
      end

      -- Init servers for NixOS
      if is_nixos then
        for server, config in pairs(nix_servers) do
          setup_server(server, config)
        end
      end

      -- Keymapping
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }

          -- Map 'gd' to go to definition
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

          -- Map 'gr' to find references
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

          -- Map <leader>la to show code actions
          vim.keymap.set(
            'n',
            '<leader>la',
            vim.lsp.buf.code_action,
            opts,
            { desc = 'Show code actions' }
          )

          -- Map <leader>lh to show hover documentation
          vim.keymap.set(
            'n',
            '<leader>lh',
            vim.lsp.buf.hover,
            opts,
            { desc = 'Show hover documentation' }
          )

          -- Map <leader>ls to show signature help
          vim.keymap.set(
            'n',
            '<leader>ls',
            vim.lsp.buf.signature_help,
            opts,
            { desc = 'Show signature help' }
          )
        end,
      })
    end,
  },
}
