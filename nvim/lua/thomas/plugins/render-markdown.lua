return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = {
            "markdown",
            "quarto",
            "codecompanion",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("render-markdown").setup({
                -- Let Treesitter do the real syntax work
                render_modes = { "n", "c", "t" },
                code = {
                    sign = false, -- prevents weird chunk gutter clutter
                },
                latex = {
                    enabled = true,
                },
            })
        end,
    },
}
