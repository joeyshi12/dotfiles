require('telescope').setup{
    defaults = {
        path_display = {"smart"},
        file_ignore_patterns = {
            "node_modules"
        },
        preview = {
            filesize_limit = 0.1
        }
    },
    pickers = {
        find_files = {
            theme = "dropdown"
        },
        live_grep = {
            theme = "dropdown"
        },
        buffers = {
            theme = "dropdown"
        },
        git_files = {
            theme = "dropdown"
        },
        git_status = {
            theme = "dropdown"
        }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})
vim.keymap.set('n', '<leader>pc', builtin.git_status, {})
