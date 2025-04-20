local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

autocmd("FileType", {
	group = augroup("indent"),
	callback = function()
		vim.o.expandtab = true
		vim.o.shiftwidth = 2
		vim.o.softtabstop = 2
		vim.o.tabstop = 2
	end,
	pattern = {
		"astro",
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"markdown",
		"sh",
		"typescript",
		"typescriptreact",
	},
	desc = "Set indentation to 2 spaces for specific filetypes.",
})

autocmd("FocusGained", {
	group = augroup("checktime"),
	command = "checktime",
	desc = "Reload file if it changed outside of neovim.",
})

autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight on yank.",
})

autocmd("FileType", {
	group = augroup("spellwrap"),
	callback = function()
		vim.o.spell = true
		vim.o.wrap = true
	end,
	pattern = { "gitcommit", "markdown" },
	desc = "Enable spell check and line wrap for gitcommit and markdown files.",
})

autocmd("BufReadPre", {
	command = "set filetype=dotenv",
	pattern = ".env*",
	desc = "Set filetype to `dotenv` for all files starting with `.env`.",
})

autocmd("InsertEnter", {
	group = augroup("insert_center"),
	command = "normal zz",
	desc = "Center document when entering insert mode.",
})
