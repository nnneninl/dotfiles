return {
	"folke/snacks.nvim",
	keys = {
		{
			"<LEADER>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Find buffers.",
		},
		{
			"<LEADER>ff",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find files.",
		},
		{
			"<LEADER>fg",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Grep.",
		},
		{
			"<LEADER>f<S-g>",
			function()
				require("snacks").picker.grep_buffers()
			end,
			desc = "Grep open buffers.",
		},
		{
			"<LEADER>fs",
			function()
				require("snacks").picker.grep_word()
			end,
			desc = "Grep for string under cursor or highlighted text.",
			mode = { "n", "x" },
		},
		{
			"<LEADER>fh",
			function()
				require("snacks").picker.help()
			end,
			desc = "Find help tags.",
		},
		{
			"<LEADER>u",
			function()
				require("snacks").picker.undo()
			end,
			desc = "Open undo history.",
		},
	},
	config = function()
		require("snacks").setup({
			picker = {
				layout = {
					preset = "ivy_split",
					cycle = false,
				},
				layouts = {
					ivy_split = {
						layout = {
							backdrop = false,
							box = "vertical",
							border = "",
							height = 0.4,
							position = "bottom",
							width = 0,
							{ win = "input", height = 1, border = ""},
							{
								box = "horizontal",
								{ win = "list", border = "" },
								{ win = "preview", title = "{preview}", width = 0.6, border = "" },
							},
						},
					},
				},
				prompt = "> ",
				icons = {
					files = {
						enabled = false,
					},
				},
			},
		})
	end,
}
