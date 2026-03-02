return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim" },
        { "ray-x/lsp_signature.nvim" },
    },
    config = function()
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local lsp_signature = require("lsp_signature")
        local keymap = vim.keymap

        local capabilities = cmp_nvim_lsp.default_capabilities()

        vim.diagnostic.config({
            signs = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = "󰠠 ",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local opts = { buffer = ev.buf, silent = true }

                -- lsp_signature (attach once per buffer)
                lsp_signature.on_attach({
                    bind = true,
                    handler_opts = { border = "rounded" },
                    hint_enable = true,
                    hint_prefix = "🐼 ",
                    floating_window = true,
                    floating_window_above_cur_line = true,
                }, ev.buf)

                -- Keymaps
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
            end,
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "svelte",
                "graphql",
                "emmet_ls",
                "lua_ls",
                "clangd",
                "arduino_language_server",
                "angularls",
                "ts_ls",
                "rust_analyzer",
                "pyright",
                "html",
                "cssls",
                "tailwindcss",
                "prismals",
            },
        })

        for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
            vim.lsp.config(server, {
                capabilities = capabilities,
            })
        end
        local lspconfig = require("lspconfig")

        vim.lsp.config("clangd", {
            capabilities = capabilities,
            filetypes = { "ino", "c", "cpp", "h", "hpp" },
        })

        vim.lsp.config("r", {
            cmd = { "R", "--slave", "-e", "languageserver::run()" },
            filetypes = { "r", "rmd", "quarto" },
            root_dir = lspconfig.util.root_pattern(".git", ".Rproj"),
            capabilities = capabilities,
            settings = {
                r = {
                    lsp = {
                        rich_documentation = true,
                    },
                },
            },
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        vim.lsp.config("arduino_language_server", {
            cmd = {
                "arduino-language-server",
                "-cli",
                "/opt/homebrew/bin/arduino-cli",
                "-cli-config",
                os.getenv("HOME") .. "/Library/Arduino15/arduino-cli.yaml",
                "-fqbn",
                "arduino:avr:mega", -- adjust to your board
                "-libraries",
                os.getenv("HOME") .. "/Documents/Arduino/libraries",
            },
            filetypes = { "c", "cpp", "h", "hpp" },
        })
    end,
}
