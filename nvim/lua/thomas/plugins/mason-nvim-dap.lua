-- language adapters for nvim-dap
return {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
        require("mason").setup()

        require("mason-nvim-dap").setup({
            ensure_installed = { "codelldb", "python", "js-debug-adapter" }, -- Debuggers to auto-install
            automatic_setup = true,
        })

        require("mason-nvim-dap").setup({
            function(config)
                require("mason-nvim-dap").default_setup(config)
            end,
        })
    end,
}
