return {
  'stevearc/conform.nvim',
  event = 'VimEnter',
  lazy = false,
  dependencies = { 'mason.nvim' },
  config = function()
    require('conform').setup {
      default_format_opts = {
        lsp_format = 'never', -- Configure if and when LSP should be used for formatting.
        timeout_ms = 500, -- Time in milliseconds to block for formatting. Defaults to 1000. No effect if async = true.
        async = false, -- If true the method won't block. Defaults to false. If the buffer is modified before the formatter completes, the formatting will be discarded.
        quiet = false, -- Don't show any notifications for warnings or failures.
      },
      formatters_by_ft = {
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
        ['_'] = { 'trim_whitespace' },
      },
      formatters = { },
     },
    }
  end,
}
