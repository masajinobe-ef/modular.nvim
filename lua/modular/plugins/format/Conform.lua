return {
    'stevearc/conform.nvim',
    event = 'VimEnter',
    lazy = false,
    config = function()
        local function get_bin(pkg)
            local exepath = vim.fn.exepath(pkg)
            return exepath ~= '' and exepath or pkg
        end

        require('conform').setup {
            -- format_on_save = {
            --     timeout_ms = 500,
            --     lsp_fallback = true,
            -- },

            formatters_by_ft = {
                lua = { 'stylua' },
                nix = { 'nixfmt' },
                python = { 'ruff_format' },
                javascript = { 'prettierd' },
                javascriptreact = { 'prettierd' },
                typescript = { 'prettierd' },
                typescriptreact = { 'prettierd' },
                html = { 'prettierd' },
                css = { 'prettierd' },
                json = { 'prettierd' },
                yaml = { 'prettierd' },
                markdown = { 'prettierd' },
                vue = { 'prettierd' },
                ruby = { 'rubocop' },
                go = { 'gofmt' },
                rust = { 'rustfmt' },
                kotlin = { 'ktlint' },
                sh = { 'shfmt' },
                scss = { 'prettierd' },
                less = { 'prettierd' },
                toml = { 'taplo' },
                graphql = { 'prettierd' },
                terraform = { 'terraform_fmt' },
                hcl = { 'terraform_fmt' },
            },
            formatters = {
                stylua = {
                    command = get_bin 'stylua',
                    args = { '--search-parent-directories', '-' },
                    stdin = true,
                },
                nixfmt = {
                    command = get_bin 'nixfmt',
                    stdin = true,
                },
                ruff_format = {
                    command = get_bin 'ruff',
                    args = { 'format', '--quiet', '-' },
                    stdin = true,
                },
                prettierd = {
                    command = get_bin 'prettierd',
                    stdin = true,
                },
                rubocop = {
                    command = get_bin 'rubocop',
                    args = {
                        '--auto-correct',
                        '--format',
                        'quiet',
                        '--stderr',
                        '--stdin',
                        '$FILENAME',
                    },
                    stdin = true,
                },
                gofmt = {
                    command = get_bin 'gofmt',
                    stdin = true,
                },
                rustfmt = {
                    command = get_bin 'rustfmt',
                    args = { '--edition=2021' },
                    stdin = true,
                },
                ktlint = {
                    command = get_bin 'ktlint',
                    args = { '--format', '--stdin' },
                    stdin = true,
                },
                shfmt = {
                    command = get_bin 'shfmt',
                    args = { '-i', '2' },
                    stdin = true,
                },
                taplo = {
                    command = get_bin 'taplo',
                    args = { 'format', '-' },
                    stdin = true,
                },
                terraform_fmt = {
                    command = get_bin 'terraform',
                    args = { 'fmt', '-' },
                    stdin = true,
                },
            },
        }

        vim.api.nvim_create_user_command('Format', function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(
                    0,
                    args.line2 - 1,
                    args.line2,
                    true
                )[1]
                range = {
                    start = { args.line1, 0 },
                    ['end'] = { args.line2, end_line:len() },
                }
            end

            require('conform').format {
                async = true,
                lsp_format = 'fallback',
                range = range,
            }
        end, {
            desc = 'Format the current buffer or selected lines',
            range = true,
        })

        vim.keymap.set(
            { 'n', 'v' },
            '<leader>f',
            '<cmd>Format<CR>',
            { desc = 'Format buffer or selection' }
        )
    end,
}
