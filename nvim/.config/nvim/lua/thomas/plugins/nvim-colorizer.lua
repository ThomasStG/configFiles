return {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
        filetypes = { "*" },
        RGB = true,
        RRGGBB = true,
        names = true,
        rgb_fn = true,
        hsl_fn = true,
        mode = "virtualtext",
        virtualtext = "■",
        virtualtext_inline = true,
    },
}
