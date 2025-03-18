return {
    "rcarriga/nvim-notify",
    config = function()
        require("notify").setup({
            background_colour = "#000000", -- Prevent transparency issues
            merge_duplicates = true,
        })
        vim.notify = require("notify")
    end,
}
