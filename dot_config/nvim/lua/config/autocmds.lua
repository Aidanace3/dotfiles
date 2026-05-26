-- this serves as a global override for all lsp configuration settings
utils.lsp.on_attach(function(client, bufnr)
    -- damn nil check
    if client == nil or client.server_capabilities == nil then
        vim.notify("Couldn't setup language server settings", vim.log.levels.ERROR)
        return
    end

    vim.lsp.codelens.enable(false, { bufnr = bufnr }) -- codelens
    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr }) -- inlay hints
    vim.lsp.semantic_tokens.enable(false, { bufnr = bufnr }) -- lsp based syntax highlighting
end)
-- autocmd.lua
-- macro recording on notify
vim.api.nvim_create_autocmd("RecordingEnter", {
    callback = function()
        vim.notify(
            string.format("Recording macro to [%s]", vim.fn.reg_recording()),
            vim.log.levels.INFO,
            { title = "Macro" }
        )
    end,
})

-- macro recording done notify
vim.api.nvim_create_autocmd("RecordingLeave", {
    callback = function()
        vim.notify("Stopped recording macro", vim.log.levels.INFO, { title = "Macro" })
    end,
})
