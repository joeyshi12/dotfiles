-- Use tab indents for dwm source code
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/**/dwm/*.c", "*/**/dwm/*.h" },
    callback = function()
        vim.bo.expandtab = false
    end
})
