local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node -- dynamic node that conditionally adds ", n = " if user typed something
local function maybe_add_n(args)
    local val = args[1][1]
    if val ~= "" then
        return ls.snippet_node(nil, { t(", n = "), i(1) })
    else
        return ls.snippet_node(nil, {})
    end
end

ls.add_snippets(
    "cpp",
    {
        s("fori", {
            t("for (int i = "),
            i(1, "0"),
            d(2, maybe_add_n, { 1 }),
            t("; i < "),
            i(3, "n"),
            t("; i++) {"),
            t({ "", " " }),
            i(0, "// body"),
            t({ "", "}" }),
        }),
    }
)
