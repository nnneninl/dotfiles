return {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	config = function()
		require("colorizer").setup({
			lazy_load = true,
			user_default_options = {
				css = true,
				tailwind = true,
			},
		})
	end,
}
