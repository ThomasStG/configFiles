return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        input = {
            -- your input configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        lazygit = { enabled = true },
    },
    keys = {
        {
            "<leader>lg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
    },
}
