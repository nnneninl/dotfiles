return {
	"catgoose/nvim-colorizer.lua",
	--event = { "BufNewFile", "BufReadPre" },
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			user_default_options = {
				css = true,
				css_fn = true,
				tailwind = true,
			},
		})
	end,
}
