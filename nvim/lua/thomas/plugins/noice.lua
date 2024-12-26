return {
    "folke/noice.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp", -- Optional, required for completion features
    },
    config = function()
        require("noice").setup({
            lsp = {
                progress = { enabled = false },
                hover = { enabled = false },
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify", -- view for errors
                view_warn = "notify", -- view for warnings
                view_history = "messages", -- view for :messages
                view_search = "virtualtext",
            },
        })
    end,
}
