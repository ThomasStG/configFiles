return {
    {
        "echasnovski/mini.nvim", -- Specify the plugin path
        version = "*", -- Use the latest version
        config = function()
            -- Enable mini.pairs (automatic pairing of brackets and quotes)
            require("mini.ai").setup()
            require("mini.align").setup()
            require("mini.completion").setup({
                checkout = "stable",
                lsp_completion = {
                    source_func = "omnifunc", -- Keep default
                },
                window = {
                    config = function()
                        if vim.bo.filetype == "markdown" then
                            return { delay = 0 } -- Disable completion in Markdown
                        end
                        return {}
                    end,
                },
            })
            require("mini.move").setup()
        end,
    },
}
