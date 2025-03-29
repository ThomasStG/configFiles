return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    lazy = false,
    priority = 1000, -- Ensure it loads early
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua",
                "html",
                "javascript",
                "typescript",
                "tsx",
                "css",
                "markdown",
                "markdown_inline",
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
