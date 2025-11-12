-- Use tab indents for dwm source code
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/**/dwm/*.c", "*/**/dwm/*.h" },
    callback = function()
        vim.bo.expandtab = false
    end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Save cursor position
    local save_cursor = vim.fn.getpos(".")

    -- Remove trailing whitespace
    vim.cmd([[%s/\s\+$//e]])

    -- Restore cursor position
    vim.fn.setpos(".", save_cursor)
  end,
})
