return {
  'stevearc/conform.nvim',
  event = 'VimEnter',
  lazy = false,
  dependencies = { 'mason.nvim' },
  config = function()
    require('conform').setup {
      default_format_opts = {
        lsp_format = 'never',
        timeout_ms = 500,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        sh = { 'shfmt' },
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
      formatters = {},
    }
  end,
}
