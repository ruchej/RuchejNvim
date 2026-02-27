-- Neo-tree configuration
require('neo-tree').setup({
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,

    default_component_configs = {
        indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
        },
        icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '󰜌',
            default = '*',
        },
    },

    window = {
        position = 'left',
        width = 40,
    },

    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_name = {
                '.git',
                'node_modules',
                '__pycache__',
                '.venv',
                'venv',
            },
        },
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
    },
})
