return {
    "epwalsh/obsidian.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
        "nvim-telescope/telescope.nvim",
        "preservim/vim-markdown",
    },
    version = "*",
    lazy = true,
    ft = "markdown",
    opts = {

        workspaces = {
            {
                name = "personal",
                path = "Users/thomas/.obsidian/personal",
            },
            {
                name = "school",
                path = "Users/thomas/.obsidian/school",
            },
        },
        mappings = {
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },
    },
}
