---@diagnostic disable: missing-parameter
-- NOTE: bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Define fallback colorscheme in case settings.theme isn't globally declared yet
local default_theme = "pioneer"
if settings and settings.theme then
    default_theme = settings.theme
end

require("lazy").setup({
    -- Uncommenting your spec directory paths so Neovim actually loads your plugins!
    spec = {
        -- Uncommenting your spec directory paths so they actually load!
        { import = "plugins" }, 
        { import = "plugins.misc" },
    },
    checker = { enabled = false },
    defaults = { version = "*" },
    install = { colorscheme = { default_theme } },
    news = { lazy = true },
    rocks = { enabled = false },
    ui = { wrap = true },
    performance = {
        cache = { enabled = true },
        reset_packpath = true,
        rtp = {
            reset = true,
            paths = {},
        },
    },
})
