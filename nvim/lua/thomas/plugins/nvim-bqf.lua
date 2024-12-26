return {
    "kevinhwang91/nvim-bqf",
    config = function()
        require("bqf").setup({
            auto_enable = true, -- Automatically enable for quickfix lists
            preview = {
                win_height = 12, -- Preview window height
            },
        })
    end,
}
