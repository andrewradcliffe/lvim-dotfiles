-- set conceallevel only for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt.conceallevel = 1
    end,
})

-- set wrap for markdown files
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = { "*.md" },
    command = "setlocal wrap"
})

-- clear recent command after 5 seconds
vim.api.nvim_create_autocmd("CmdlineLeave", {
    callback = function()
        vim.fn.timer_start(5000, function()
            vim.cmd [[ echon ' ' ]]
        end)
    end
})

