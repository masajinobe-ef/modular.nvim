return {
    'mfussenegger/nvim-lint',
    config = function()
        local opts = {
            -- Event to trigger linters
            events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
            linters_by_ft = {
                python = { 'ruff' },
                kotlin = { 'ktlint' },
                ['*'] = { 'codespell' },
            },
            linters = {
                -- Example of using selene only when a selene.toml file is present
                -- selene = {
                --   condition = function(ctx)
                --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1] ~= nil
                --   end,
                -- },
            },
        }

        require('lint').linters_by_ft = opts.linters_by_ft
        require('lint').linters = opts.linters
        -- Commenting out the set_linter_options call
        -- require('lint').set_linter_options(opts)
    end,
}
