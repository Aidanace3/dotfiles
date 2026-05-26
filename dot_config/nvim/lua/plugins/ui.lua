return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy", -- Only load when needed, keeping startup fast
        opts = {
        -- WhichKey v3 settings
        preset = "modern",
        },
            config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

            -- Define your groups here
            wk.add({
              { "<leader>f", group = "find" },
              { "<leader>g", group = "git" },
              { "<leader>x", group = "diagnostics/trouble" },
              { "<leader>b", group = "buffer" },
              { "<leader>w", group = "windows" },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- 1. Grab your exact Pioneer palette colors
            local pioneer_colors = {
                bg       = "NONE",     -- Keep the core statusline glass/transparent
                fg       = "#d8c8e8",  -- Pale purple text
                pink     = "#d98ba8",  -- Normal mode tag (soft pink)
                mauve    = "#b89fd0",  -- Insert mode tag (mauve)
                lavender = "#b8a8d8",  -- Visual mode tag (soft lavender)
                peach    = "#d8b890",  -- Replace mode tag (dusty peach)
                surface  = "#1a1220",  -- Subtle darker purple container for secondary info
            }

            -- 2. Build the explicit mode color map
            local pioneer_lualine_theme = {
                normal = {
                    a = { bg = pioneer_colors.pink, fg = pioneer_colors.surface, bold = true },
                    b = { bg = pioneer_colors.surface, fg = pioneer_colors.fg },
                    c = { bg = pioneer_colors.bg, fg = pioneer_colors.fg },
                },
                insert = {
                    a = { bg = pioneer_colors.mauve, fg = pioneer_colors.surface, bold = true },
                    b = { bg = pioneer_colors.surface, fg = pioneer_colors.fg },
                },
                visual = {
                    a = { bg = pioneer_colors.lavender, fg = pioneer_colors.surface, bold = true },
                    b = { bg = pioneer_colors.surface, fg = pioneer_colors.fg },
                },
                replace = {
                    a = { bg = pioneer_colors.peach, fg = pioneer_colors.surface, bold = true },
                    b = { bg = pioneer_colors.surface, fg = pioneer_colors.fg },
                },
                inactive = {
                    a = { bg = pioneer_colors.surface, fg = pioneer_colors.fg },
                    b = { bg = pioneer_colors.surface, fg = pioneer_colors.fg },
                    c = { bg = pioneer_colors.bg, fg = pioneer_colors.fg },
                },
            }

            -- 3. Setup lualine with the new theme object
            require("lualine").setup({
                options = {
                    theme = pioneer_lualine_theme, -- Load your custom color object here!
                    globalstatus = true,
                    component_separators = { left = "╱", right = "╱" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = { statusline = { "dashboard", "alpha", "oil" } },
                    always_divide_middle = true,
                },
                sections = {
                lualine_a = { { "mode", separator = { left = " " }, right_padding = 2 } },
                lualine_b = { 
                    { function() return "" end, color = { fg = pioneer_colors.lavender, bold = true }, padding = { left = 1, right = 1 } },
                    { "filename", file_status = true, path = 0 } 
                },
                lualine_c = {},
                    lualine_x = { 
                        "encoding", 
                        { function() return ":3" end, color = { fg = pioneer_colors.mauve } } 
                    },
                lualine_y = { "filetype", "progress" },
                lualine_z = { "location" },
                },
            })

            -- Force the header placement rules
            vim.opt.winbar = nil
            vim.opt.laststatus = 0
            vim.opt.tabline = "%{%v:lua.require'lualine'.api.get_statusline()%}"
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- 1. PURGE THE DASHBOARD FOR REAL THIS TIME
            dashboard = {
                enabled = false,
            },
            -- 2. Keep clean notifications
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            -- 3. Glass-friendly background scope dimmer
            dim = {
                enabled = true,
                scope = { min_changed = 2 },
            },
            gitgutter = {
                enabled = true,
            },
            terminal = {
                enabled = true,
            },
        },
        keys = {
            { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratchpad" },
            { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        },
        config = function(_, opts)
            require("snacks").setup(opts)

            -- Keep floating popups transparent so they never block your view
            vim.api.nvim_create_autocmd("User", {
                pattern = "SnacksVisualUpdate",
                callback = function()
                    local float_groups = { "SnacksNormal", "SnacksBorder" }
                    for _, group in ipairs(float_groups) do
                        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
                    end
                end,
            })
        end,
    },
    vim.cmd("colorscheme pioneer")
}
