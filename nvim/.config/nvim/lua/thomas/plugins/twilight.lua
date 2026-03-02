return {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
        {
            "<leader>tw",
            function()
                require("twilight").toggle()
            end,
            desc = "Toggle Twilight",
        },
    },
    config = function()
        require("twilight").setup({
            treesitter = true, -- use Treesitter for scope detection
            expand = {},
            exclude = {}, -- optional: list of filetypes to exclude
            context = 0, -- disables line-count based context
        })
    end,
}
