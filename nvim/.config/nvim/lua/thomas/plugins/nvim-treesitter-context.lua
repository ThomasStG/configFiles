return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
        require("treesitter-context").setup({
            enable = true, -- Show context
            max_lines = 5, -- Show up to 5 lines of context
            trim_scope = "outer", -- Trim outer context if too long
        })
    end,
}
