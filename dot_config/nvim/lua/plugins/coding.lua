return {
    -- 1. LSP Configuration Engine
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            -- Mason manages automatic downloads for your language compilers
            require("mason").setup({
                ui = {
                    border = "rounded",
                    -- Force Mason's installer window to inherit your Pioneer transparency
                    icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" }
                }
            })

            require("mason-lspconfig").setup({
                -- Add whatever languages you code in here (e.g., lua_ls)
                ensure_installed = { "lua_ls" }, 
            })

            local lspconfig = require("lspconfig")
            
            -- Inject glass layout behaviors directly into the default LSP hover windows
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "rounded",
            })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
                border = "rounded",
            })

            -- Simple hook to configure your local Lua server with automated settings
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- Clean keymaps for code intelligence
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Documentation Hover" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
        end,
    },
    {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        -- This disables the specific Treesitter-based decoration provider that is crashing
        modes = {
            diagnostics = {
                win = { position = "bottom", height = 10 },
            },
        },
        -- DISABLE the integration causing the crash
        treesitter = false, 
    },
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    },
    config = function(_, opts)
        require("trouble").setup(opts)
        
        -- Keep your transparency autocmds here...
        vim.api.nvim_create_autocmd("ColorScheme", {
            callback = function()
                local trouble_groups = {"TroubleNormal", "TroubleNormalNC", "TroubleWindow"}
                for _, group in ipairs(trouble_groups) do
                    vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
                end
            end,
        })
    end,
},
    -- 2. Autocompletion Engine (nvim-cmp) - CONSOLIDATED & CLEANED
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip", -- Snippet engine dependency
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept auto-suggestions with Enter
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim-lsp" },
                    { name = "path" },
                    { name = "buffer" },
                }),
                -- THE GLASS MAGIC: Strip background vectors from completion box overlays
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:NormalFloat,BorderFloat:FloatBorder,CursorLine:PmenuSel,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "Normal:NormalFloat,BorderFloat:FloatBorder,CursorLine:PmenuSel,Search:None",
                    }),
                },
                -- Inline ghost text suggestions active!
                experimental = {
                    ghost_text = true,
                },
            })

            -- Style the ghost text so it looks like a soft, faded mauve whisper ahead of your cursor
            vim.api.nvim_set_hl(0, "CmpGhostText", { fg = "#5c4d63", italic = true })
            
            -- Hook the highlight group directly to the completion engine's ghost text output
            vim.api.nvim_create_autocmd("User", {
                pattern = "CmpAutocomplete",
                callback = function()
                    vim.api.nvim_set_hl(0, "CmpItemKindGhostText", { link = "CmpGhostText" })
                end,
            })

            -- Force core completion menus to remain perfectly translucent
            vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", ctermbg = "NONE" })
            vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#2a1d30", fg = "#d98ba8", bold = true }) -- Pioneer pink cursor bar highlight!
        end,
    },
}
