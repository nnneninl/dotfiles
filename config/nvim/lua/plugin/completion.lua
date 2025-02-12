return {
	-- hrsh7th/nvim-cmp {{{
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "emoji" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						item.menu = ({
							nvim_lsp = "[LSP]",
							emoji = "[EMOJI]",
							luasnip = "[SNIP]",
							buffer = "[BUF]",
							path = "[PATH]",
						})[entry.source.name]
						return item
					end,
				},
				window = {
					completion = {
						border = { " " },
					},
					documentation = {
						border = { " " },
					},
				},
			})
		end,
	},
	--}}}
	-- L3MON4D3/LuaSnip {{{
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		build = "make install_jsregexp",
		version = "v2.*", -- follow latest release
		config = function()
			local luasnip = require("luasnip")

			luasnip.filetype_extend("javascript", { "jsdoc" })
			luasnip.filetype_extend("javascriptreact", { "html", "jsdoc", "react-es7" })
			luasnip.filetype_extend("templ", { "html" })
			luasnip.filetype_extend("typescript", { "tsdoc" })
			luasnip.filetype_extend("typescriptreact", { "html", "tsdoc", "react-ts" })

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	--}}}
}
