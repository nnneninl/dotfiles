local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup("plugin", {
	change_detection = { enabled = false },
	defaults = { lazy = true, version = false },
	install = { colorscheme = { "default" } },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"spellfile",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		icons = {
			cmd = "[CMD]",
			config = "[CFG]",
			event = "[EVT]",
			ft = "[FT]",
			init = "[INI]",
			import = "[IMP]",
			keys = "[KEY]",
			lazy = "[LZY]",
			loaded = "[LD]",
			not_loaded = "[!LD]",
			plugin = "[PLG]",
			runtime = "[RT]",
			require = "[REQ]",
			source = "[SRC]",
			start = "[STR]",
			task = "[TSK]",
			list = {
				"@",
				"+",
				"*",
				"-",
			},
		},
	},
})

vim.keymap.set("n", "<LEADER><SPACE>", "<CMD>Lazy<CR>", { desc = "Open Lazy." })
