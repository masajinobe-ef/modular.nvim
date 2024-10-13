return {
    'mfussenegger/nvim-lint',
    config = function()
        local opts = {
            events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
            linters_by_ft = {
                python = { 'ruff' },
                kotlin = { 'ktlint' },
                ['*'] = { 'codespell' },
            },
            linters = {},
        }

        require('lint').linters_by_ft = opts.linters_by_ft
        require('lint').linters = opts.linters
    end,
}
