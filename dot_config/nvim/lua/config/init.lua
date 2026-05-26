--- @brief
---
--- Loads:
--- * vim options
--- * lazy.nvim plugin manager
--- * auto commands
--- * keymaps
--- in sequential order
--- THE ORDER MATTERS

local modules = {
    "config.options",
    "config.lazy",
    -- "config.autocmds",
    -- "config.keymaps",
}

for _, v in ipairs(modules) do
    require(v)
end
