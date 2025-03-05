return {
    "numToStr/Navigator.nvim",
    lazy = true,
    config = function()
        require("Navigator").setup({
            keymaps = {
                left = "<C-h>",
                down = "<C-j>",
                up = "<C-k>",
                right = "<C-l>",
            },
            disable_default_keybindings = false,
            style = "minimal",
            disable_on_zoom = true,
            mux = "auto",
        })
    end,
}
