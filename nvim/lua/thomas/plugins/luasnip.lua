return {
    "L3MON4D3/LuaSnip",
    config = function()
        local ls = require("luasnip")
        local map = vim.keymap.set
        ls.setup({
            history = true, -- allows jumping back into old snippets
            updateevents = "TextChanged,TextChangedI", -- live updates
            enable_autosnippets = true, -- optional
        })

        -- Optional: also load VSCode/Lua snippets if you ever add them
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "~/.config/nvim/LuaSnip" },
        })
        require("luasnip.loaders.from_snipmate").lazy_load({
            paths = { "~/.config/nvim/snippets" },
        })
        require("luasnip.loaders.from_vscode").lazy_load()

        -- Keymaps for convenience
        map({ "i", "s" }, "<Tab>", function()
            if ls.expand_or_jumpable() then
                return "<Plug>luasnip-expand-or-jump"
            else
                return "<Tab>"
            end
        end, { expr = true, silent = true })

        map({ "i", "s" }, "<S-Tab>", function()
            if ls.jumpable(-1) then
                return "<Plug>luasnip-jump-prev"
            else
                return "<S-Tab>"
            end
        end, { expr = true, silent = true })

        -- nvim dap ui

        map("", "<leader>du", function()
            require("dapui").toggle({})
        end, { desc = "Dap UI" })
        map({ "n", "v" }, "<leader>de", function()
            require("dapui").eval()
        end, { desc = "Eval" })
    end,
    build = "make install_jsregexp",
}
