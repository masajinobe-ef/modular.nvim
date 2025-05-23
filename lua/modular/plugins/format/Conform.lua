return {
  'stevearc/conform.nvim',
  event = 'VimEnter',
  lazy = false,
  dependencies = { 'mason.nvim' },
  config = function()
    local is_nixos = vim.fn.filereadable('/etc/NIXOS') == 1

    -- Системные форматтеры для NixOS
    local nix_formatters = {
      lua = { vim.fn.exepath('stylua') },
      sh = { vim.fn.exepath('shfmt') },
      nix = { vim.fn.exepath('nixfmt') },
      bash = { vim.fn.exepath('shfmt') },
      python = { vim.fn.exepath('ruff') },
      go = { vim.fn.exepath('goimports'), vim.fn.exepath('gofmt') },
      kotlin = { vim.fn.exepath('ktlint') },
      cpp = { vim.fn.exepath('clang-format') },

      javascript = { vim.fn.exepath('prettierd') },
      typescript = { vim.fn.exepath('prettierd') },
      javascriptreact = { vim.fn.exepath('prettierd') },
      typescriptreact = { vim.fn.exepath('prettierd') },
      html = { vim.fn.exepath('prettierd') },
      css = { vim.fn.exepath('prettierd') },
      jsonc = { vim.fn.exepath('prettierd') },
      json = { vim.fn.exepath('prettierd') },
      markdown = { vim.fn.exepath('prettierd') },
      yaml = { vim.fn.exepath('prettierd') },
      xml = { vim.fn.exepath('prettierd') },

      ['*'] = { vim.fn.exepath('codespell') },
      ['_'] = { vim.fn.exepath('trim_whitespace') }
    }

    -- Форматтеры для других ОС (используют Mason)
    local default_formatters = {
      lua = { 'stylua' },
      sh = { 'shfmt' },
      nix = { 'nixfmt' },
      bash = { 'shfmt' },
      python = { 'ruff' },
      go = { 'goimports', 'gofmt' },
      kotlin = { 'ktlint' },
      cpp = { 'clang-format' },

      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      html = { 'prettierd' },
      css = { 'prettierd' },
      jsonc = { 'prettierd' },
      json = { 'prettierd' },
      markdown = { 'prettierd' },
      yaml = { 'prettierd' },
      xml = { 'prettierd' },

      ['*'] = { 'codespell' },
      ['_'] = { 'trim_whitespace' }
    }

    require('conform').setup {
      default_format_opts = {
        lsp_format = 'never',
        timeout_ms = 500,
        async = false,
        quiet = false,
      },
      formatters_by_ft = is_nixos and nix_formatters or default_formatters,
      formatters = {}
    }

    if is_nixos then
      -- Отключаем Mason для форматтеров в NixOS
      require('mason').setup {
        PATH = 'skip', -- Предотвращает модификацию PATH
        registries = { 'mason-registry' } -- Оставляем пустым
      }
    end
  end
}
