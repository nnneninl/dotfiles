return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = "nvim-lua/plenary.nvim",
	keys = {
		{
			"<LEADER>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Mark file with harpoon.",
		},
		{
			"<C-e>",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list(), { border = { "" }, title = "" })
			end,
			desc = "Open harpoon list.",
		},
		{
			"<C-h>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Switch to harpoon mark 1.",
		},
		{
			"<C-j>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Switch to harpoon mark 2.",
		},
		{
			"<C-k>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Switch to harpoon mark 3.",
		},
		{
			"<C-l>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Switch to harpoon mark 4.",
		},
	},
	config = function()
		require("harpoon"):setup({
			settings = { save_on_toggle = true },
		})
	end,
}
