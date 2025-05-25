return {
  'stevearc/conform.nvim',
  event = 'VimEnter',
  lazy = false,
  config = function()
    local is_nixos = vim.fn.filereadable '/etc/NIXOS' == 1

    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'nixfmt' },
        python = { 'ruff_format' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        html = { 'prettierd' },
        css = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
        vue = { 'prettierd' },
        svelte = { 'prettierd' },
        php = { 'php_cs_fixer' },
        ruby = { 'rubocop' },
        go = { 'gofmt' },
        rust = { 'rustfmt' },
        java = { 'google_java_format' },
        kotlin = { 'ktlint' },
        cs = { 'dotnet_format' },
        sh = { 'shfmt' },
        terraform = { 'terraform_fmt' },
        scss = { 'prettierd' },
        less = { 'prettierd' },
        sql = { 'sqlfmt' },
        toml = { 'taplo' },
        graphql = { 'prettierd' },
        dockerfile = { 'dockerfmt' },
        ['*'] = { 'codespell' },
        ['_'] = { 'trim_whitespace' },
      },
      formatters = {
        stylua = {
          command = is_nixos and vim.fn.exepath 'stylua' or 'stylua',
          args = { '--search-parent-directories', '-' },
          stdin = true,
        },
        nixfmt = {
          command = is_nixos and vim.fn.exepath 'nixfmt' or 'nixfmt',
          stdin = true,
        },
        ruff_format = {
          command = is_nixos and vim.fn.exepath 'ruff' or 'ruff',
          args = { 'format', '-' },
          stdin = true,
        },
        prettierd = {
          command = is_nixos and vim.fn.exepath 'prettierd' or 'prettierd',
          stdin = true,
        },
        codespell = {
          command = is_nixos and vim.fn.exepath 'codespell' or 'codespell',
          args = { '--quiet', '2' },
          stdin = false,
        },
        trim_whitespace = {
          command = is_nixos and vim.fn.exepath 'trim_whitespace'
            or 'trim_whitespace',
          args = { '--trim' },
          stdin = false,
        },
      },
    }
  end,
}
