_G.utils = {
    ---@param plugin string
    ---@return boolean
    has = function(plugin)
        if package.loaded["lazy"] then
            return require("lazy.core.config").plugins[plugin] ~= nil
        else
            local plugin_name = vim.split(plugin, ".", { plain = true, trimempty = true })
            return package.loaded[plugin_name[1]] ~= nil
        end
    end,
    lsp = {
        ---@param on_attach fun(client: vim.lsp.Client?, bufnr: integer)
        on_attatch = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    utils.lsp.on_attach(client, bufnr)
                end,
            })
        end,
    },
}
require("config")
