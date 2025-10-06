return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            path_display = { "smart" },
            file_ignore_patterns = { "node_modules" },
        },
        pickers = {
            find_files = {
                hidden = true,
                no_ignore = false,
            },
            live_grep = {
                theme = "dropdown",
            },
            buffers = {
                theme = "dropdown",
            },
            git_files = {
                theme = "dropdown",
            },
            git_status = {
                theme = "dropdown",
            },
        },
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>pf", builtin.git_files, {})
        vim.keymap.set("n", "<leader>pc", builtin.git_status, {})
    end,
}
