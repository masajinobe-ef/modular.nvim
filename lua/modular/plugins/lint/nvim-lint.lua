return {
    {
        'mfussenegger/nvim-lint',
        event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
        config = function()
            local lint = require 'lint'
            lint.linters_by_ft = {
                python = { 'ruff' },
                kotlin = { 'ktlint' },
                bash = { 'shellcheck' },
                ['*'] = { 'codespell' },
            }
            local lint_augroup =
                vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd(
                { 'BufEnter', 'BufWritePost', 'InsertLeave' },
                {
                    group = lint_augroup,
                    callback = function()
                        lint.try_lint()
                    end,
                }
            )
        end,
    },
}
