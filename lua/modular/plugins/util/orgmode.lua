return {
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            require('orgmode').setup({
                org_agenda_files = '~/Sync/org/**/*',
                org_default_notes_file = '~/Sync/org/refile.org',
            })
        end,
    }
}
