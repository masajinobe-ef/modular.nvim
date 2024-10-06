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
                    'prettier',
                    stop_after_first = true,
                },
                typescript = {
                    'prettierd',
                    'prettier',
                    stop_after_first = true,
                },
                html = { 'prettierd', 'prettier', stop_after_first = true },
                css = { 'prettierd', 'prettier', stop_after_first = true },
                json = { 'prettierd', 'prettier', stop_after_first = true },
                markdown = { 'prettierd', 'prettier', stop_after_first = true },
                yaml = { 'prettierd', 'prettier', stop_after_first = true },
                xml = { 'prettierd', 'prettier', stop_after_first = true },
                ['*'] = { 'codespell' },
                ['_'] = { 'trim_whitespace' },
            },
        }
    end,
}
