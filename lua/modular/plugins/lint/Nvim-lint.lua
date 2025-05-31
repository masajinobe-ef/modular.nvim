return {
    {
        'mfussenegger/nvim-lint',
        event = { 'BufRead', 'BufWritePost', 'TextChanged' },
        config = function()
            local lint = require 'lint'

            local function get_bin(bin_name)
                local exepath = vim.fn.exepath(bin_name)
                return exepath ~= '' and exepath or bin_name
            end

            local function configure_linter(name, config)
                lint.linters[name] = lint.linters[name] or {}
                for key, value in pairs(config) do
                    lint.linters[name][key] = value
                end
            end

            configure_linter('ruff', {
                cmd = get_bin 'ruff',
                args = {
                    'check',
                    '--quiet',
                    '--exit-zero',
                    '--format=text',
                    '--stdin-filename',
                    '$FILENAME',
                    '-',
                },
                stdin = true,
                stream = 'stdout',
                ignore_exitcode = true,
            })

            configure_linter('ktlint', {
                cmd = get_bin 'ktlint',
                args = { '--relative', '--stdin' },
                stdin = true,
                stream = 'stderr',
            })

            configure_linter('shellcheck', {
                cmd = get_bin 'shellcheck',
                args = { '--format', 'gcc', '--external-sources', '-' },
                stdin = true,
            })

            configure_linter('eslint_d', {
                cmd = get_bin 'eslint_d',
                args = {
                    '--stdin',
                    '--stdin-filename',
                    '$FILENAME',
                    '--format',
                    'compact',
                },
                stdin = true,
                stream = 'both',
            })

            configure_linter('luacheck', {
                cmd = get_bin 'luacheck',
                args = {
                    '--formatter',
                    'plain',
                    '--codes',
                    '--ranges',
                    '--globals',
                    'vim',
                    'setup',
                    '-',
                },
                stdin = true,
            })

            configure_linter('golangci-lint', {
                cmd = get_bin 'golangci-lint',
                args = {
                    'run',
                    '--out-format',
                    'line-number',
                    '--path-prefix',
                    '$DIRNAME',
                },
                stdin = false,
            })

            configure_linter('yamllint', {
                cmd = get_bin 'yamllint',
                args = { '--format', 'parsable', '-' },
                stdin = true,
            })

            configure_linter('markdownlint', {
                cmd = get_bin 'markdownlint',
                args = { '--stdin' },
                stdin = true,
            })

            configure_linter('hadolint', {
                cmd = get_bin 'hadolint',
                args = { '-' },
                stdin = true,
            })

            configure_linter('jsonlint', {
                cmd = get_bin 'jsonlint',
                args = { '--compact' },
                stdin = true,
            })

            configure_linter('stylelint', {
                cmd = get_bin 'stylelint',
                args = {
                    '--formatter',
                    'json',
                    '--stdin-filename',
                    '$FILENAME',
                },
                stdin = true,
            })

            configure_linter('tflint', {
                cmd = get_bin 'tflint',
                args = { '--format=default', '--force' },
                stdin = false,
            })

            configure_linter('htmlhint', {
                cmd = get_bin 'htmlhint',
                args = { '--format', 'unix', '--stdin' },
                stdin = true,
            })

            configure_linter('rubocop', {
                cmd = get_bin 'rubocop',
                args = {
                    '--format',
                    'emacs',
                    '--force-exclusion',
                    '--stdin',
                    '$FILENAME',
                },
                stdin = true,
            })

            lint.linters_by_ft = {
                python = { 'ruff' },
                kotlin = { 'ktlint' },
                bash = { 'shellcheck' },
                sh = { 'shellcheck' },
                javascript = { 'eslint_d' },
                typescript = { 'eslint_d' },
                javascriptreact = { 'eslint_d' },
                typescriptreact = { 'eslint_d' },
                lua = { 'luacheck' },
                go = { 'golangci-lint' },
                yaml = { 'yamllint' },
                markdown = { 'markdownlint' },
                dockerfile = { 'hadolint' },
                json = { 'jsonlint' },
                css = { 'stylelint' },
                scss = { 'stylelint' },
                terraform = { 'tflint' },
                hcl = { 'tflint' },
                html = { 'htmlhint' },
                vue = { 'eslint_d' },
                ruby = { 'rubocop' },
            }

            local lint_augroup =
                vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd(
                { 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' },
                {
                    group = lint_augroup,
                    callback = function()
                        vim.defer_fn(function()
                            lint.try_lint()
                        end, 150)
                    end,
                }
            )

            vim.schedule(function()
                lint.try_lint()
            end)
        end,
    },
}
