-- global vim variables
vim.g.editorconfig = true
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.markdown_recommended_style = 0
-- global options
vim.go.tabline = "%!v:lua.require('misc.ui.tabline').activate()"

-- options
--- shell
local shell = { main = "zsh", fallback = "bash" }
vim.o.shell = vim.fn.exepath(shell.main) ~= "" and vim.fn.exepath(shell.main) or vim.fn.exepath(shell.fallback)
--- ui
vim.o.conceallevel = 0
vim.o.concealcursor = ""
vim.o.confirm = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.number = true
vim.o.relativenumber = false
vim.o.showmode = false
vim.o.showtabline = 1
vim.o.signcolumn = "yes"
--- indents
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
--- spell checker
vim.o.spell = false
vim.o.spelllang = "en_us"
--- terminal
vim.o.termguicolors = true
vim.o.termsync = true
--- fold
vim.o.fillchars = "foldopen:,foldclose:,fold: ,foldsep: ,diff:╱,eob: "
vim.o.foldcolumn = "0"
vim.o.foldenable = true
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- default to treesitter folding
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldtext = ""
--- highlights for spaces and tabs
vim.o.list = false
vim.o.listchars = "tab: ->,space:."
--- special
vim.o.autoread = true
vim.o.autowrite = false
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.exrc = true
vim.o.wrap = false
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.sessionoptions = "curdir,folds,help,tabpages,winsize"
vim.o.scrolloff = 5
--- search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

-- diagnostic options
vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_lines = false,
    virtual_text = false,
})

vim.o.diffopt = "internal,filler,closeoff,linematch:60,algorithm:histogram,indent-heuristic"

-- WARN: enable experimental UI features
require("vim._core.ui2").enable({})
vim.o.cmdheight = 0
