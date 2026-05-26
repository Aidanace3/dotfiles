return {
    -- 1. Telescope: Fuzzy finding files, text, and buffers
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Grep Search" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Find Buffers" },
        },
        config = function()
            local telescope = require("telescope")
            
            telescope.setup({
                defaults = {
                    -- Clean, minimal sharp borders for the search popups
                    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                },
            })
            -- THE GLASS EFFECT: Inject transparency directly into Telescope's UI layers
            local telescope_groups = {
                "TelescopeNormal",
                "TelescopeBorder",
                "TelescopePromptNormal",
                "TelescopePromptBorder",
                "TelescopeResultsNormal",
                "TelescopeResultsBorder",
                "TelescopePreviewNormal",
                "TelescopePreviewBorder",
            }
            
            for _, group in ipairs(telescope_groups) do
                vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
            end
        end,
    },
    -- 2. Oil.nvim: Edit your file directories exactly like a text buffer
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                default_file_explorer = true,
                columns = { "icon" },
                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<C-p>"] = "actions.preview",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                },
                view_options = {
                    show_hidden = true, -- Always reveal hidden dotfiles (.config, etc.)
                },
            })
            -- Map the minus key to instantly open the parent directory
            vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            
            -- Ensure Oil windows never draw a solid back canvas layer
            vim.api.nvim_set_hl(0, "OilNormal", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "OilNormalNC", { bg = "NONE", ctermbg = "NONE" })
        end,
    },
    -- 3. Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
}
