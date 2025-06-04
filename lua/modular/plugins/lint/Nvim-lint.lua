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

            configure_linter('ruff', {
                cmd = get_bin('ruff'),
                args = {
                    'check',
                    '--no-fix',
                    '--quiet',
                    '--exit-zero',
                    '--format=json',
                    '-',
                },
                stdin = true,
                stream = 'stdout',
                ignore_exitcode = true,
            })

            -- configure_linter('nixpkgs-lint', {
            --     cmd = get_bin 'nixpkgs-lint',
            --     args = {
            --         '--format',
            --         'json',
            --         '--include-unfinished-lints',
            --         '--stdin',
            --     },
            --     stdin = true,
            --     stream = 'stdout',
            --     ignore_exitcode = true,
            -- })

            -- configure_linter('hadolint', {
            --     cmd = get_bin 'hadolint',
            --     args = {
            --         '-',
            --         '--no-fail',
            --         '-f',
            --         'json',
            --     },
            --     stdin = true,
            --     stream = 'stdout',
            --     ignore_exitcode = true,
            -- })

            -- configure_linter('shellcheck', {
            --     cmd = get_bin 'shellcheck',
            --     args = {
            --         '-',
            --         '--severity',
            --         'warning',
            --     },
            --     stdin = true,
            --     stream = 'stdout',
            --     ignore_exitcode = true,
            -- })

            -- configure_linter('rslint', {
            --     cmd = get_bin 'rslint',
            --     args = {
            --         '-',
            --         '--fix',
            --     },
            --     stdin = true,
            --     stream = 'stdout',
            --     ignore_exitcode = true,
            -- })

            -- configure_linter('markdownlint-cli', {
            --     cmd = get_bin 'markdownlint',
            --     args = {
            --         '-',
            --         '-q',
            --     },
            --     stdin = true,
            --     stream = 'stdout',
            --     ignore_exitcode = true,
            -- })

            -- configure_linter('yamllint', {
            --     cmd = get_bin 'yamllint',
            --     args = {
            --         '-',
            --         '--format',
            --         'parsable',
            --         '--no-warnings',
            --     },
            --     stdin = true,
            --     stream = 'stdout',
            --     ignore_exitcode = true,
            -- })

            lint.linters_by_ft = {
                lua = { 'luacheck' },
                python = { 'ruff' },
                -- typescript = { 'rslint' },
                -- nix = { 'nixpkgs-lint' },
                -- dockerfile = { 'hadolint' },
                -- sh = { 'shellcheck' },
                -- bash = { 'shellcheck' },
                -- zsh = { 'shellcheck' },
                -- markdown = { 'markdownlint-cli' },
                -- yaml = { 'yamllint' },
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
