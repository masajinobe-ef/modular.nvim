return {
    'stevearc/conform.nvim',
    event = 'VimEnter',
    dependencies = { 'mason.nvim' },
    lazy = true,
    config = function()
        require('conform').setup {
            formatters_by_ft = {
                lua = { 'stylua' },
                python = { 'ruff' },
                rust = { 'rustfmt', lsp_format = 'fallback' },
                javascript = {
                    'prettierd',
                    'prettier',
                    stop_after_first = true,
                },
                typescript = {
                    'prettierd',
                    'prettier',
                    stop_after_first = true,
                },
                sh = { 'shfmt' },
                go = { 'gofmt', 'goimports' },
                html = { 'prettier' },
                css = { 'prettier' },
                json = { 'prettier' },
                markdown = { 'prettier' },
                yaml = { 'prettier' },
                xml = {
                    'prettierd',
                    'prettier',
                    stop_after_first = true,
                },
                ['*'] = { 'codespell' },
                ['_'] = { 'trim_whitespace' },
            },
        }
    end,
}
