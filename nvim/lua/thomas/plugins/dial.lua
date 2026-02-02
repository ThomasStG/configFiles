return {
    "monaqa/dial.nvim",
    lazy = false,
    config = function()
        local augend = require("dial.augend")
        local map = vim.keymap.set
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
        local dial = require("dial.map")

        local mappings = {
            { { "n" }, "<leader><C-k>", "increment", "normal", "Increment" },
            { { "n" }, "<leader><C-j>", "decrement", "normal", "Decrement" },
            { { "n", "v" }, "<leader>gk", "increment", "gnormal", "Increment (g)" },
            { { "n", "v" }, "<leader>gj", "decrement", "gnormal", "Decrement (g)" },
            { { "v" }, "<leader>k", "increment", "visual", "Increment (Visual)" },
            { { "v" }, "<leader>j", "decrement", "visual", "Decrement (Visual)" },
        }

        for _, m in ipairs(mappings) do
            local modes, lhs, action, dial_mode, desc = unpack(m)
            map(modes, lhs, function()
                dial.manipulate(action, dial_mode)
            end, { desc = desc })
        end
    end,
}
