return {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
        require('rose-pine').setup {
            variant = 'moon',
            dark_variant = 'moon',
            dim_inactive_windows = false,
            extend_background_behind_borders = true,
            enable = {
                terminal = true,
                legacy_highlights = true,
                migrations = true,
            },
            styles = {
                bold = true,
                italic = true,
                transparency = true,
            },
            groups = {
                border = 'muted',
                link = 'iris',
                panel = 'surface',
                error = 'love',
                hint = 'iris',
                info = 'foam',
                note = 'pine',
                todo = 'rose',
                warn = 'gold',
                git_add = 'foam',
                git_change = 'rose',
                git_delete = 'love',
                git_dirty = 'rose',
                git_ignore = 'muted',
                git_merge = 'iris',
                git_rename = 'pine',
                git_stage = 'iris',
                git_text = 'rose',
                git_untracked = 'subtle',
                h1 = 'iris',
                h2 = 'foam',
                h3 = 'rose',
                h4 = 'gold',
                h5 = 'pine',
                h6 = 'foam',
            },
            palette = {
                moon = {
                    palette = {
                        base = '#191724',
                        surface = '#1f1d2e',
                        overlay = '#26233a',
                        muted = '#6e6a86',
                        subtle = '#908caa',
                        text = '#e0def4',
                        love = '#ff4c4c',
                        gold = '#f6c177',
                        rose = '#ffb3b3',
                        pine = '#4caf50',
                        foam = '#9ccfd8',
                        iris = '#c4a7e7',
                        highlight_low = '#21202e',
                        highlight_med = '#403d52',
                        highlight_high = '#524f67',
                    },
                },
            },
            highlight_groups = {
                -- Comment = { fg = "foam" },
                -- VertSplit = { fg = "muted", bg = "muted" },
            },
            --before_highlight = function(group, highlight, palette)
            -- Disable all undercurls
            -- if highlight.undercurl then
            --     highlight.undercurl = false
            -- end
            --
            -- Change palette colour
            -- if highlight.fg == palette.pine then
            --     highlight.fg = palette.foam
            -- end
            --end,
        }

        vim.cmd 'colorscheme rose-pine'
    end,
}
