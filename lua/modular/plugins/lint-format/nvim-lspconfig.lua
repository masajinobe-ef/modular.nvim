return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup(
                    'kickstart-lsp-attach',
                    { clear = true }
                ),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(
                            mode,
                            keys,
                            func,
                            { buffer = event.buf, desc = 'LSP: ' .. desc }
                        )
                    end

                    -- Mappings for LSP features
                    map(
                        'gd',
                        require('telescope.builtin').lsp_definitions,
                        '[g]oto [d]efinition'
                    )
                    map(
                        'gr',
                        require('telescope.builtin').lsp_references,
                        '[g]oto [r]eferences'
                    )
                    map(
                        'gI',
                        require('telescope.builtin').lsp_implementations,
                        '[g]oto [I]mplementation'
                    )
                    map(
                        '<leader>D',
                        require('telescope.builtin').lsp_type_definitions,
                        'type [D]efinition'
                    )
                    map(
                        '<leader>ds',
                        require('telescope.builtin').lsp_document_symbols,
                        '[d]ocument [s]ymbols'
                    )
                    map(
                        '<leader>ws',
                        require('telescope.builtin').lsp_dynamic_workspace_symbols,
                        '[w]orkspace [s]ymbols'
                    )
                    map('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
                    map(
                        '<leader>ca',
                        vim.lsp.buf.code_action,
                        '[c]ode [a]ction',
                        { 'n', 'x' }
                    )
                    map('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')

                    local client =
                        vim.lsp.get_client_by_id(event.data.client_id)
                    if
                        client
                        and client.supports_method(
                            vim.lsp.protocol.Methods.textDocument_documentHighlight
                        )
                    then
                        local highlight_augroup = vim.api.nvim_create_augroup(
                            'kickstart-lsp-highlight',
                            { clear = false }
                        )
                        vim.api.nvim_create_autocmd(
                            { 'CursorHold', 'CursorHoldI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            }
                        )
                        vim.api.nvim_create_autocmd(
                            { 'CursorMoved', 'CursorMovedI' },
                            {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.clear_references,
                            }
                        )
                    end

                    if
                        client
                        and client.supports_method(
                            vim.lsp.protocol.Methods.textDocument_inlayHint
                        )
                    then
                        map('<leader>th', function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled {
                                    bufnr = event.buf,
                                }
                            )
                        end, '[t]oggle Inlay [h]ints')
                    end
                end,
            })

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend(
                'force',
                capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            completion = { callSnippet = 'Replace' },
                            diagnostics = {
                                globals = { 'vim' }, -- Ignore 'vim' as undefined global
                            },
                        },
                    },
                },

            }

            -- Extend `ensure_installed` with your list of servers and tools
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua',
                'ruff',
                'marksman',
                'rust_analyzer',
                'gopls',
                'html',
                'jsonls',
                'dockerls',
                'bashls',
                'ts_ls',
                'tailwindcss',
                'cssls',
                'yamlls',
                'sqlls',
                'kotlin_language_server',
                'lua_ls',
                'jdtls',
            })

            require('java').setup()


            require('mason').setup()
            require('mason-tool-installer').setup {
                ensure_installed = ensure_installed,
            }
            require('mason-lspconfig').setup {
                handlers = {
                    function(server_name)
                        local server = servers[server_name] or {}
                        server.capabilities = vim.tbl_deep_extend(
                            'force',
                            {},
                            capabilities,
                            server.capabilities or {}
                        )
                        require('lspconfig')[server_name].setup(server)
                    end,
                },
            }
        end,
    },
}
