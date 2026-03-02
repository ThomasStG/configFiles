return {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    keys = {
        {
            "<leader>sr",
            function()
                require("spectre").open()
            end,
            desc = "Open Spectre",
        },
        {
            "<leader>sw",
            function()
                require("spectre").open_visual({ select_word = true })
            end,
            mode = "n",
            desc = "Search current word",
        },
        {
            "<leader>sw",
            function()
                require("spectre").open_visual()
            end,
            mode = "v",
            desc = "Search selection",
        },
        {
            "<leader>sp",
            function()
                require("spectre").open_file_search({ select_word = true })
            end,
            desc = "Search in current file",
        },
    },
    opts = {
        open_cmd = "vnew", -- opens in a vertical split
        live_update = true, -- auto update results while typing
        is_insert_mode = false,
    },
}
