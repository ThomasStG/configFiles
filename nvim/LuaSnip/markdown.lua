local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node

local function make_matrix_nodes(rows, cols)
    local nodes = {}
    for r = 1, rows do
        for c = 1, cols do
            table.insert(nodes, i((r - 1) * cols + c, "a_" .. r .. c))
            if c < cols then
                table.insert(nodes, t(" & "))
            end
        end
        if r < rows then
            table.insert(nodes, t({ " \\\\", "" }))
        end
    end
    return nodes
end

ls.add_snippets("markdown", {
    s("mat", {
        f(function()
            local input = vim.fn.input("Matrix size (rows x cols): ")
            local r, c = input:match("(%d+)x(%d+)")
            return { tonumber(r) or 1, tonumber(c) or 1 }
        end, {}),
        t("\\[\\begin{"),
        i(1, "pmatrix"),
        t("}"),
        d(2, function(args)
            local rows = args[1][1]
            local cols = args[1][2]
            return make_matrix_nodes(rows, cols)
        end, { 1 }),
        t({ "", "\\end{" }),
        i(1),
        t("}\\]"),
    }),
})
