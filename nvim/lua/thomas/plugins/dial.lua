return {
    "monaqa/dial.nvim",
    lazy = false,
    keys = {
        {
            "<Leader>C-k",
            function()
                require("dial.map").manipulate("increment", "normal")
            end,
            desc = "Increment",
        },
        {
            "<Leader>C-j",
            function()
                require("dial.map").manipulate("decrement", "normal")
            end,
            desc = "Decrement",
        },
        {
            "<Leader>gk",
            function()
                require("dial.map").manipulate("increment", "gnormal")
            end,
            mode = { "n", "v" },
            desc = "Increment (g)",
        },
        {
            "<Leader>gj",
            function()
                require("dial.map").manipulate("decrement", "gnormal")
            end,
            mode = { "n", "v" },
            desc = "Decrement (g)",
        },
        {
            "<Leader>k",
            function()
                require("dial.map").manipulate("increment", "visual")
            end,
            mode = "v",
            desc = "Increment (Visual)",
        },
        {
            "<Leader>j",
            function()
                require("dial.map").manipulate("decrement", "visual")
            end,
            mode = "v",
            desc = "Decrement (Visual)",
        },
    },
    config = function()
        local augend = require("dial.augend")
        require("dial.config").augends:register_group({
            default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.date.alias["%Y/%m/%d"],
                augend.date.alias["%m/%d/%Y"],
                augend.constant.alias.bool,
                augend.constant.new({ elements = { "and", "or" } }),
                augend.constant.new({ elements = { "True", "False" }, word = true, cyclic = true }),
                augend.constant.new({ elements = { "yes", "no" }, word = true, cyclic = true }),
            },
        })
    end,
}
