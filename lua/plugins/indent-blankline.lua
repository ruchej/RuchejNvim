-- Indent-blankline configuration
return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPost',
    opts = {
        indent = {
            char = '│',
            tab_char = '│',
        },
        scope = {
            enabled = false,
        },
        exclude = {
            filetypes = {
                'help',
                'dashboard',
                'neo-tree',
                'Trouble',
                'trouble',
                'lazy',
                'mason',
                'notify',
                'toggleterm',
                'lspinfo',
                'checkhealth',
                'man',
                'gitcommit',
                'TelescopePrompt',
                'TelescopeResults',
            },
        },
    },
}
