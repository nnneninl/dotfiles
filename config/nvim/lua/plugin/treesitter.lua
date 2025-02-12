return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufNewFile", "BufReadPre" },
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
		{ "windwp/nvim-ts-autotag", config = true },
	},
	build = ":TSUpdate",
	keys = {
		{
			"<leader>tp",
			function()
				vim.treesitter.inspect_tree()
			end,
			desc = "Toggle InspectTree.",
		},
		{
			"<leader>gc",
			function()
				require("treesitter-context").go_to_context()
			end,
			desc = "Go to context.",
		},
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				-- essential
				"c",
				"lua",
				"query",
				"vim",
				"vimdoc",
				-- for me
				"bash",
				"css",
				"dockerfile",
				"go",
				"html",
				"javascript",
				"json",
				"markdown",
				"markdown_inline",
				"python",
				"rust",
				"svelte",
				"templ",
				"tsx",
				"typescript",
			},
			highlight = { enable = true },
		})
	end,
}
