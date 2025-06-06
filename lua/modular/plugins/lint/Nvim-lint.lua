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

            -- Lua
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

            -- Python
            configure_linter('ruff', {
                cmd = get_bin 'ruff',
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

            -- C/C++
            configure_linter('clang-tidy', {
                cmd = get_bin 'clang-tidy',
                args = {
                    '--quiet',
                    '$FILENAME',
                },
                stdin = false, -- Use filename instead of stdin
                stream = 'stdout',
                ignore_exitcode = true,
            })

            -- Docker
            configure_linter('hadolint', {
                cmd = get_bin 'hadolint',
                args = {
                    '--no-fail',
                    '-f',
                    'json',
                    '$FILENAME',
                },
                stdin = false, -- Use filename instead of stdin
                stream = 'stdout',
                ignore_exitcode = true,
            })

            -- Shell
            configure_linter('shellcheck', {
                cmd = get_bin 'shellcheck',
                args = {
                    '--format=json',
                    '$FILENAME',
                },
                stdin = false, -- Use filename instead of stdin
                stream = 'stdout',
                ignore_exitcode = true,
            })

            -- JavaScript/TypeScript
            configure_linter('eslint_d', {
                cmd = get_bin 'eslint_d',
                args = {
                    '--stdin',
                    '--stdin-filename',
                    '$FILENAME',
                    '--format=json',
                },
                stdin = true,
                stream = 'stdout',
                ignore_exitcode = true,
            })

            -- YAML
            configure_linter('yamllint', {
                cmd = get_bin 'yamllint',
                args = {
                    '--format=parsable',
                    '-',
                },
                stdin = true,
                stream = 'stdout',
                ignore_exitcode = true,
            })

            -- Markdown
            configure_linter('markdownlint', {
                cmd = get_bin 'markdownlint',
                args = {
                    '--stdin',
                },
                stdin = true,
                stream = 'stderr',
                ignore_exitcode = true,
            })

            lint.linters_by_ft = {

                lua = { 'luacheck' },
                python = { 'ruff' },

                -- Shell family
                sh = { 'shellcheck' },
                bash = { 'shellcheck' },
                zsh = { 'shellcheck' },

                -- JavaScript family
                javascript = { 'eslint_d' },
                javascriptreact = { 'eslint_d' },
                typescript = { 'eslint_d' },
                typescriptreact = { 'eslint_d' },

                -- Web formats
                html = { 'eslint_d' },
                css = { 'eslint_d' },
                json = { 'eslint_d' },

                -- Config files
                yaml = { 'yamllint' },
                toml = {},

                -- Documentation
                markdown = { 'markdownlint' },

                -- C family
                c = { 'clang-tidy' },
                cpp = { 'clang-tidy' },
                h = { 'clang-tidy' },
                hpp = { 'clang-tidy' },
                objc = { 'clang-tidy' },
                objcpp = { 'clang-tidy' },

                -- Docker
                dockerfile = { 'hadolint' },

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
