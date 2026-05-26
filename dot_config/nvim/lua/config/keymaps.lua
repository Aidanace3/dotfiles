-- Helper function to generate fresh options every time
local function make_opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- 1. CLIPBOARD
vim.keymap.set({ "n", "v" }, "d", '"_d', make_opts("delete"))
vim.keymap.set("n", "dd", '"_dd', make_opts("delete line"))
vim.keymap.set("n", "D", '"_D', make_opts("delete till end of line"))

vim.keymap.set({ "n", "v" }, "c", '"_c', make_opts("change"))
vim.keymap.set("n", "cc", '"_cc', make_opts("change line"))
vim.keymap.set("n", "C", '"_C', make_opts("change till end of line"))

vim.keymap.set({ "n", "v" }, "x", "d", make_opts("cut"))
vim.keymap.set("n", "xx", "dd", make_opts("cut line"))
vim.keymap.set("n", "X", "D", make_opts("cut till end of line"))

vim.keymap.set({ "n", "v" }, "s", '"_s', make_opts("select"))
vim.keymap.set("n", "S", '"_S', make_opts("select line"))

-- 2. FILE & SESSION
vim.keymap.set("n", "<leader>ww", "<cmd>w<cr>", make_opts("write file"))
vim.keymap.set("n", "<leader>wa", "<cmd>wa<cr>", make_opts("write all files"))
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", make_opts("quit/session"))
vim.keymap.set("n", "<leader>qq", "<cmd>wqa<cr>", make_opts("quit & save"))
vim.keymap.set("n", "<leader>qQ", "<cmd>qa!<cr>", make_opts("quit without saving"))
vim.keymap.set("n", "<leader>qr", "<cmd>restart<cr>", "restart editor")

-- 3. WINDOW RESIZING
vim.keymap.set("n", "<M-Up>", "<cmd>resize +5<cr>", make_opts("resize height +5"))
vim.keymap.set("n", "<M-Down>", "<cmd>resize -5<cr>", make_opts("resize height -5"))
vim.keymap.set("n", "<M-Left>", "<cmd>vertical resize -5<cr>", make_opts("resize width -5"))
vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +5<cr>", make_opts("resize width +5"))

-- 4. LSP SETUP
utils.lsp.on_attach(function(client, bufnr)
    -- Which-key handles the descriptions now, so we pass only the buffer option
    local ls_opts = { buffer = bufnr }

    if client:supports_method("textDocument/definition") then
        vim.keymap.set("n", "<localleader>gd", vim.lsp.buf.definition, ls_opts)
    end
    
    if client:supports_method("textDocument/rename") then
        vim.keymap.set("n", "<localleader>rn", vim.lsp.buf.rename, ls_opts)
        vim.keymap.set("n", "<localleader>rf", Snacks.rename.rename_file, ls_opts)
    end

    -- Repeat pattern for your other LSP calls...
    -- Important: Do not use make_opts() inside on_attach because you 
    -- need to pass the `buffer = bufnr` field.
end)
