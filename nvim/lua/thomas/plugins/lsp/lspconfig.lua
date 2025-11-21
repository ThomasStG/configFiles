return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        { "ray-x/lsp_signature.nvim" },
    },
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        local lsp_signature = require("lsp_signature")
        local keymap = vim.keymap

        local function on_attach(client, bufnr)
            lsp_signature.on_attach({
                bind = true,
                handler_opts = { border = "rounded" },
                hint_enable = true,
                hint_prefix = "🐼 ",
                floating_window = true,
                floating_window_above_cur_line = true,
            }, bufnr)
            local opts = { buffer = bufnr, silent = true }

            opts.desc = "Show LSP references"
            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

            opts.desc = "Show LSP implementations"
            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts)

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

            -- Add lsp_signature support
            lsp_signature.on_attach({
                bind = true,
                handler_opts = { border = "rounded" },
            }, bufnr)
        end

        local capabilities = cmp_nvim_lsp.default_capabilities()

        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        vim.diagnostic.config({
            signs = {
                [vim.diagnostic.severity.ERROR] = signs.Error,
                [vim.diagnostic.severity.WARN] = signs.Warn,
                [vim.diagnostic.severity.INFO] = signs.Info,
                [vim.diagnostic.severity.HINT] = signs.Hint,
            },
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
            },
        })

        for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
            if
                not vim.tbl_contains(
                    { "svelte", "graphql", "emmet_ls", "lua_ls", "clangd", "arduino_language_server", "angularls" },
                    server
                )
            then
                lspconfig[server].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                })
            end
        end

        lspconfig["svelte"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    callback = function(ctx)
                        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                    end,
                })
            end,
        })
        lspconfig["ts_ls"].setup({
            on_attach = function(client, bufnr)
                -- optional: show function signatures
                require("lsp_signature").on_attach({
                    bind = true,
                    handler_opts = { border = "rounded" },
                }, bufnr)
            end,
            settings = {
                typescript = {
                    format = { semicolons = "insert" },
                },
            },
        })
        lspconfig["graphql"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        })

        lspconfig["emmet_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = {
                "html",
                "typescriptreact",
                "javascriptreact",
                "css",
                "sass",
                "scss",
                "less",
                "svelte",
            },
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })

        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=never" },
        })

        lspconfig["arduino_language_server"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "arduino-language-server",
                "-cli-config",
                "/path/to/arduino-cli.yaml",
                "-fqbn",
                "arduino:avr:uno",
            },
        })

        lspconfig["angularls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "ngserver",
                "--stdio",
                "--tsProbeLocations",
                vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
                "--ngProbeLocations",
                vim.fn.stdpath("data") .. "/mason/packages/angular-language-server/node_modules",
            },
            filetypes = { "typescript", "html", "typescriptreact", "angular" },
            root_dir = lspconfig.util.root_pattern("angular.json", "project.json", "tsconfig.json"),
        })
    end,
}
