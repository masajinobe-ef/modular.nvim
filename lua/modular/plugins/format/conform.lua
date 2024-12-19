return {
  'stevearc/conform.nvim',
  event = 'VimEnter',
  lazy = false,
  dependencies = { 'mason.nvim' },
  config = function()
    require('conform').setup {
      -- Set default options for formatters
      default_format_opts = {
        lsp_format = 'fallback',
        timeout_ms = 500,
        async = true,
        quiet = false,
      },
      formatters_by_ft = {
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        python = { 'ruff' },
        lua = { 'stylua' },
        go = { 'goimports', 'gofmt' },
        kotlin = { 'ktlint' },
        cpp = { 'clang-format' },
        javascript = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        typescript = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        html = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        css = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        json = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        markdown = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        yaml = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        xml = {
          'prettierd',
          'prettier',
          timeout_ms = 2000,
          stop_after_first = true,
        },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
      },
      formatters = {
        -- stylua = {
        --   -- env = {
        --   --     -- YAMLFIX_SEQUENCE_STYLE = "block_style",
        --   --     -- YAMLFIX_WHITELINES = "1",
        --   --     -- YAMLFIX_LINE_LENGTH = "120",
        --   -- },
        -- },
      },
    }
  end,
}
