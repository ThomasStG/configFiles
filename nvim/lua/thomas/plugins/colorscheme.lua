return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        local bg = "#011629"
        local bg_dark = "#011424"
        local bg_highlight = "#143653"
        local bg_search = "#1A64AC"
        local bg_visual = "#275379"
        local fg = "#CBE1F0"
        local fg_dark = "#B5D0E9"
        local fg_gutter = "#628E97"
        local border = "#547999"

        require("tokyonight").setup({
            style = "night",
            on_colors = function(colors)
                colors.bg = bg
                colors.bg_dark = bg_dark
                colors.bg_float = bg_dark
                colors.bg_highlight = bg_highlight
                colors.bg_popup = bg_dark
                colors.bg_search = bg_search
                colors.bg_sidebar = bg_dark
                colors.bg_statusline = bg_dark
                colors.bg_visual = bg_visual
                colors.border = border
                colors.fg = fg
                colors.fg_dark = fg_dark
                colors.fg_float = fg
                colors.fg_gutter = fg_gutter
                colors.fg_sidebar = fg_dark
            end,
        })

        vim.cmd("colorscheme tokyonight")
    end,
}
