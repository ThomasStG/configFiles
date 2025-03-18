return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- Load when opening files
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "html", "javascript", "typescript", "tsx", "vue", "svelte" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
