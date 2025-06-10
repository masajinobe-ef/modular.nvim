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
            formatters_by_ft = {

                lua = { 'stylua' },
                python = { 'ruff' },

                -- Shell family
                sh = { 'shfmt' },
                bash = { 'shfmt' },
                zsh = { 'shfmt' },

                -- JavaScript family
                javascript = { 'prettierd' },
                javascriptreact = { 'prettierd' },
                typescript = { 'prettierd' },
                typescriptreact = { 'prettierd' },

                -- Web formats
                html = { 'prettierd' },
                css = { 'prettierd' },
                json = { 'prettierd' },

                -- Config files
                -- yaml = { 'yamlfmt' },
                toml = { 'taplo' },

                -- Documentation
                markdown = { 'prettierd' },

                -- C family
                c = { 'clang_format' },
                cpp = { 'clang_format' },
                h = { 'clang_format' },
                hpp = { 'clang_format' },
                objc = { 'clang_format' },
                objcpp = { 'clang_format' },

                -- Rust
                rust = { 'rustfmt' },

            },

            formatters = {

                -- Lua
                stylua = {
                    command = get_bin 'stylua',
                    args = { '--search-parent-directories', '-' },
                    stdin = true,
                },

                -- Python
                ruff = {
                    command = get_bin 'ruff',
                    args = { 'format', '--quiet', '-' },
                    stdin = true,
                },

                -- Shell (sh/bash/zsh)
                shfmt = {
                    command = get_bin 'shfmt',
                    args = { '-i', '2', '-s', '-' },
                    stdin = true,
                },

                -- js/ts/jsx/tsx/html/css/json/markdown
                prettierd = {
                    command = get_bin 'prettierd',
                    stdin = true,
                },

                -- yaml
                -- yamlfmt = {
                --     command = get_bin 'yamlfmt',
                --     args = { 'format', '-' },
                --     stdin = true,
                -- },

                -- toml
                taplo = {
                    command = get_bin 'taplo',
                    args = { 'format', '-' },
                    stdin = true,
                },

                -- c/c++
                clang_format = {
                    command = get_bin 'clang-format',
                    args = {
                        '--assume-filename',
                        '{__FILE}',
                        '--style=file',
                        '--fallback-style=LLVM',
                    },
                    stdin = true,
                },

                -- rust
                rustfmt = {
                    command = get_bin('rustfmt'),
                    args = { '--emit', 'stdout', '--quiet' },
                    stdin = true,
                    cwd = function(ctx)
                        return vim.fs.dirname(ctx.filename)
                    end,
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
