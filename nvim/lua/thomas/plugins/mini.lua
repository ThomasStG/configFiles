return {
    {
        "echasnovski/mini.nvim", -- Specify the plugin path
        version = "*", -- Use the latest version
        config = function()
            -- Enable mini.pairs (automatic pairing of brackets and quotes)
            require("mini.ai").setup()
            require("mini.align").setup()
            require("mini.completion").setup({ checkout = "stable" })
            require("mini.operators").setup({ checkout = "stable" })
        end,
    },
}
