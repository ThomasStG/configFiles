return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- Import modules
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- Enable Mason with UI icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "?",
                    package_pending = "?",
                    package_uninstalled = "?",
                },
            },
        })

        -- Ensure LSP servers are installed
        mason_lspconfig.setup({
            ensure_installed = {
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "lua_ls",
                "graphql",
                "emmet_ls",
                "prismals",
                "pyright",
                "clangd",
                "angularls",
                "eslint",
                "biome",
                "texlab",
                "marksman",
            },
            automatic_installation = true,
        })

        -- Ensure formatters and linters are installed
        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- JavaScript/TypeScript formatter
                "stylua", -- Lua formatter
                "pylint", -- Python linter
                "eslint_d", -- ESLint daemon
            },
            auto_update = true, -- Automatically update tools
            run_on_start = true, -- Ensure tools are installed on start
        })
    end,
}
