return {
	"numToStr/Navigator.nvim",
	keys = {
		{ "<C-h>", "<cmd>NavigatorLeft<cr>" },
		{ "<C-j>", "<cmd>NavigatorDown<cr>" },
		{ "<C-k>", "<cmd>NavigatorUp<cr>" },
		{ "<C-l>", "<cmd>NavigatorRight<cr>" },
	},
	config = function()
		require("Navigator").setup({
			disable_on_zoom = true,
			mux = "auto",
		})
	end,
}
