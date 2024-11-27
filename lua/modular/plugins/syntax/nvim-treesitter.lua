return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = {
                'comment',
                'bash',
                'c',
                'diff',
                'html',
                'lua',
                'luap',
                'luadoc',
                'markdown',
                'markdown_inline',
                'query',
                'vim',
                'vimdoc',
                'rust',
                'yaml',
                'xml',
                'tsx',
                'typescript',
                'regex',
                'printf',
                'toml',
                'json',
                'jsonc',
                'jsdoc',
                'cpp',
                'python',
                'javascript',
                'go',
                'kotlin',
            },
            auto_install = true,
        },
    },
}