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
                    ruff = {
                        command = "ruff",
                        args = { "check", "--stdin", "--fix" },
                        stdin = true,
                        cwd = require("conform.util").root_file({ ".editorconfig", "pyproject.toml" }),
                        require_cwd = true,
                        tmpfile_format = ".conform.$RANDOM.$FILENAME",
                        condition = function(self, ctx)
                            return vim.fs.basename(ctx.filename) ~= "README.md"
                        end,
                        exit_codes = { 0, 1 },
                        env = {
                            LINE_LENGTH = "79",
                            EOL = "LF",
                            INDENT_STYLE = "space",
                            TAB_SIZE = "4",
                            QUOTE_STYLE = "single",
                        },
                        inherit = true,
                        prepend_args = {},
                        append_args = {},
                    },
                },

                stylua = {
                    command = "stylua",
                    args = { "--stdin", "--config-path", ".stylua.toml" },
                    stdin = true,
                    cwd = require("conform.util").root_file({ ".editorconfig", "stylua.toml" }),
                    require_cwd = true,
                    tmpfile_format = ".conform.$RANDOM.$FILENAME",
                    condition = function(self, ctx)
                        return vim.fs.basename(ctx.filename) ~= "README.md"
                    end,
                    exit_codes = { 0, 1 },
                    env = {},
                    inherit = true,
                    prepend_args = {},
                    append_args = {},
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
