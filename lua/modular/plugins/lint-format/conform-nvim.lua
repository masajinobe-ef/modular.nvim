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
                go = { 'goimports', 'gofmt' },
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

            -- Custom args
            formatters = {
                formatters = {
                    stylua = {
                        command = 'stylua',
                        args = {
                            '--column-width',
                            '79',
                            '--line-endings',
                            'Unix',
                            '--indent-type',
                            'Spaces',
                            '--indent-width',
                            '4',
                            '--quote-style',
                            'AutoPreferSingle',
                            '--call-parentheses',
                            'None',
                        },
                    },
                    ruff = {
                        command = 'ruff',
                        args = {
                            '--fix',
                            '--line-length',
                            '79',
                            '--indent-width',
                            '4',
                            '--quote-style',
                            'single',
                            '--indent-style',
                            'space',
                        },
                    },
                    prettier = {
                        command = 'prettier',
                        args = {
                            '--print-width',
                            '80',
                            '--single-quote',
                            'true',
                            '--trailing-comma',
                            'es5',
                            '--bracket-spacing',
                            'true',
                            '--prose-wrap',
                            'preserve',
                        },
                    },
                },

                -- Set default options for formatters
                default_format_opts = {
                    lsp_format = 'fallback',
                    timeout_ms = 500,
                },
            },
        }
    end,
}
