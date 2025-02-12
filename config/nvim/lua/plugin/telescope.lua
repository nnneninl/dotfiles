return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = vim.fn.has("win32") == 1
					and "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
				or "make",
		},
		"debugloop/telescope-undo.nvim",
	},
	keys = {
		{
			"<LEADER>fb",
			function()
				require("telescope.builtin").buffers({
					prompt_title = "",
					preview_title = "",
				})
			end,
			desc = "Find buffers.",
		},
		{
			"<LEADER>ff",
			function()
				require("telescope.builtin").find_files({
					prompt_title = "",
					preview_title = "",
				})
			end,
			desc = "Find files.",
		},
		{
			"<LEADER>fg",
			function()
				require("telescope.builtin").live_grep({
					prompt_title = "",
					preview_title = "",
				})
			end,
			desc = "Live grep.",
		},
		{
			"<LEADER>fh",
			function()
				require("telescope.builtin").help_tags({
					prompt_title = "",
					preview_title = "",
				})
			end,
			desc = "Find help tags.",
		},
		{
			"<LEADER>fs",
			function()
				require("telescope.builtin").grep_string({
					prompt_title = "",
					preview_title = "",
				})
			end,
			desc = "Grep for string under cursor.",
		},
		{
			"<LEADER>u",
			function()
				require("telescope").extensions.undo.undo({
					prompt_title = "",
				})
			end,
			desc = "Find buffers.",
		},
	},
	config = function()
		vim.cmd([[
			highlight TelescopeBorder guibg=#14161b guifg=#07080d
			highlight TelescopeNormal guibg=#07080d guifg=#e0e2ea
		]])
		require("telescope").setup({
			defaults = {
				borderchars = { "▄", "▌", "▀", "▐", "▗", "▖", "▘", "▝" },
				results_title = "",
			},
		})
		require("telescope").load_extension("fzf")
	end,
}
