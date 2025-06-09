return {
	"laytan/cloak.nvim",
	ft = "dotenv",
	keys = { {
		"<LEADER>ct",
		function()
			require("cloak").toggle()
		end,
		desc = "Toggle cloak.",
	} },
	config = function()
		require("cloak").setup({ enabled = true })
	end,
}
