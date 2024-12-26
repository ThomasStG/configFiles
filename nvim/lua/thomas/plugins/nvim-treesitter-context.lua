return {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    config = function()
        require("treesitter-context").setup({
            enable = true, -- Enable the context display
            max_lines = 0, -- Set 0 to show as many lines as possible
            min_window_height = 0, -- Show context regardless of window height
            line_numbers = true,
            mode = "topline",
        })
    end,
}
