vim.g.mapleader = '\\'
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("n", "<C-n>", vim.cmd.tabn)
vim.keymap.set("n", "<C-p>", vim.cmd.tabp)
