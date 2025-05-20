return {
	"iamcco/markdown-preview.nvim",
	build = "cd app && npm install && git restore .",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
	end,
	keys = {
		{
			"<LEADER>md",
			"<CMD>MarkdownPreview<CR>",
			desc = "Toggle markdown preview.",
		},
	},
	ft = { "markdown" },
}
