-- ~/.config/nvim/colors/pioneer.lua

-- Clear existing highlights if any other theme was loaded
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "pioneer"

-- 1. Define your exact Pioneer Palette from kitty.conf
local pioneer = {
    fg       = "#d8c8e8", -- Default pale purple text
    lavender = "#b8a8d8", -- color4 (soft lavender)
    mauve    = "#b89fd0", -- color2 (mauve)
    pink     = "#d98ba8", -- color1 (soft pink)
    peach    = "#d8b890", -- color3 (dusty peach)
    rose     = "#d8909d", -- color5 (rose)
}

-- 2. Apply syntax highlighting groups
vim.api.nvim_set_hl(0, "Normal", { fg = pioneer.fg })
vim.api.nvim_set_hl(0, "LineNr", { fg = pioneer.mauve })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = pioneer.pink, bold = true })

-- Code Syntax
vim.api.nvim_set_hl(0, "String", { fg = pioneer.peach })
vim.api.nvim_set_hl(0, "Keyword", { fg = pioneer.pink })
vim.api.nvim_set_hl(0, "Statement", { fg = pioneer.pink })
vim.api.nvim_set_hl(0, "Function", { fg = pioneer.lavender })
vim.api.nvim_set_hl(0, "Identifier", { fg = pioneer.fg })
vim.api.nvim_set_hl(0, "Type", { fg = pioneer.mauve })
vim.api.nvim_set_hl(0, "Comment", { fg = "#5a4a6a", italic = true }) 

-- 3. THE GLASS EFFECT: Strip all solid background elements down to NONE
local transparent_groups = {
    "Normal", "NormalNC", "Comment", "Constant", "Special",
    "Identifier", "Statement", "PreProc", "Type", "Underlined",
    "Todo", "String", "Function", "Conditional", "Repeat",
    "Operator", "Structure", "LineNr", "NonText", "SignColumn",
    "StatusLine", "StatusLineNC", "EndOfBuffer", "NormalFloat", "FloatBorder"
}

for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
end
