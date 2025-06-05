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
                python = { 'ruff' },

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

                toml = { 'taplo' },
                sh = { 'shfmt' },

                c = { 'clang_format' },
                cpp = { 'clang_format' },
                h = { 'clang_format' },
                hpp = { 'clang_format' },
                objc = { 'clang_format' },
                objcpp = { 'clang_format' },
            },

            formatters = {

                clang_format = {
                    command = get_bin 'clang-format',
                    args = {
                        '-assume-filename',
                        '$FILENAME',
                        '--style=file',
                        '--fallback-style=LLVM',
                    },
                    stdin = true,
                },

                stylua = {
                    command = get_bin 'stylua',
                    args = { '--search-parent-directories', '-' },
                    stdin = true,
                },

                ruff = {
                    command = get_bin 'ruff',
                    args = { 'format', '--quiet', '-' },
                    stdin = true,
                },

                prettierd = {
                    command = get_bin 'prettierd',
                    stdin = true,
                },

                taplo = {
                    command = get_bin 'taplo',
                    args = { 'format', '-' },
                    stdin = true,
                },

                shfmt = {
                    command = get_bin 'shfmt',
                    args = { '-i', '2' },
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
