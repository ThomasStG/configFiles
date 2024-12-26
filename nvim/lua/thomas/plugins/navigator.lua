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
        })
    end,
}
