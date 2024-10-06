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
                sh = { 'shfmt' },
                go = { 'goimports' },
                kotlin = { 'ktlint' },
                javascript = {
                    'prettierd',
                },
                typescript = {
                    'prettierd',
                },
                html = { 'prettierd' },
                css = { 'prettierd' },
                json = { 'prettierd' },
                markdown = { 'prettierd' },
                yaml = { 'prettierd' },
                xml = { 'prettierd' },
                ['*'] = { 'codespell' },
                ['_'] = { 'trim_whitespace' },
            },
        }
    end,
}
