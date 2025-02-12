return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<LEADER>e",
			function()
				require("oil").open()
			end,
			desc = "Go to parent directory.",
		},
	},
	config = function()
		require("oil").setup({
			view_options = { show_hidden = true },
		})
	end,
}
