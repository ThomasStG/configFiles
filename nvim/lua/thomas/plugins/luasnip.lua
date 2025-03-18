return {
    "L3MON4D3/LuaSnip",
    config = function()
        require("luasnip").setup()
    end,
    build = "make install_jsregexp",
}
