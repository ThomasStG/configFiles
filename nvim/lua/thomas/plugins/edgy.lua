return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        -- default layout direction, 'left'|'right'|'top'|'bottom'
        -- you can specify per-window in the config too
        -- default is 'right'
        animate = { enabled = true }, -- optional animations
        -- define your sidebar windows here
        -- keys = keys to toggle the window
        -- size = width or height depending on side
        -- open = true/false to start open or closed
        -- You can specify any buffer or filetype or custom window here

        left = {
            {
                title = "Explorer",
                ft = "neo-tree",
                size = 40,
                pinned = true,
                open = "Neotree",
                -- map key to toggle the explorer
                key = "e",
            },
        },

        bottom = {
            {
                title = "Terminal",
                ft = "toggleterm",
                size = 15,
                open = "ToggleTerm",
                key = "t",
            },
            {
                title = "Messages",
                ft = "neotest-summary", -- example for test summary window
                size = 12,
                pinned = false,
                open = function()
                    -- open function to decide when/how to open
                    return require("neotest").summary.open()
                end,
            },
        },

        -- floating window config (optional)
        float = {
            border = "rounded",
            winblend = 5,
        },
    },

    -- optionally create keymaps to toggle edgy windows globally
    keys = {
        { "<leader>el", "<cmd>Edgy toggle left<cr>", desc = "Toggle Explorer sidebar" },
        { "<leader>tb", "<cmd>Edgy toggle bottom<cr>", desc = "Toggle Terminal sidebar" },
    },
}
