return {
    'stevearc/conform.nvim',
    event = 'VimEnter',
    lazy = false,
    dependencies = { 'mason.nvim' },
    config = function()
        require('conform').setup {
            formatters_by_ft = {
                sh = { 'shfmt' },
                zsh = { 'shfmt' },
                go = { 'goimports', 'gofmt' },
                kotlin = { 'ktlint' },
                cpp = { 'clang-format' },
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
            -- Custom args
            formatters = {
                ruff = {
                    command = 'ruff format .',
                    -- env = {
                    --     YAMLFIX_SEQUENCE_STYLE = "block_style",
                    -- },
                },

                stylua = {
                    command = 'stylua -f .stylua.toml .',
                },
            },
            -- Set default options for formatters
            default_format_opts = {
                lsp_format = 'fallback',
                timeout_ms = 3000,
                async = false,
                quiet = false,
            },
        }
    end,
}
