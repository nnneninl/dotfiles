return {
	-- saghen/blink.cmp {{{
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = { "L3MON4D3/LuaSnip" },
		config = function()
			require("blink.cmp").setup({
				appearance = {
					kind_icons = {
						Text = "[TXT]",
						Method = "[MTH]",
						Function = "[FN]",
						Constructor = "[CTOR]",

						Field = "[FLD]",
						Variable = "[VAR]",
						Property = "[PROP]",

						Class = "[CLAS]",
						Interface = "[IFC]",
						Struct = "[STR]",
						Module = "[MOD]",

						Unit = "[UNT]",
						Value = "[VAL]",
						Enum = "[ENM]",
						EnumMember = "[EMEM]",

						Keyword = "[KW]",
						Constant = "[CST]",

						Snippet = "[SNIP]",
						Color = "[CLR]",
						File = "[FILE]",
						Reference = "[REF]",
						Folder = "[DIR]",
						Event = "[EVT]",
						Operator = "[OPR]",
						TypeParameter = "[TYP]",
					},
				},
				keymap = { preset = "enter" },
				completion = { documentation = { auto_show = true } },
				snippets = { preset = "luasnip" },
				sources = { default = { "lsp", "path", "snippets", "buffer" } },
			})
		end,
	},
	-- }}}
	-- L3MON4D3/LuaSnip {{{
	{
		"L3MON4D3/LuaSnip",
		dependencies = "rafamadriz/friendly-snippets",
		build = "make install_jsregexp",
		version = "v2.*", -- follow latest release
		config = function()
			local luasnip = require("luasnip")

			luasnip.filetype_extend("astro", { "html" })
			luasnip.filetype_extend("javascript", { "jsdoc" })
			luasnip.filetype_extend("javascriptreact", { "html", "jsdoc", "react-es7" })
			luasnip.filetype_extend("templ", { "html" })
			luasnip.filetype_extend("typescript", { "tsdoc" })
			luasnip.filetype_extend("typescriptreact", { "html", "tsdoc", "react-ts" })

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	-- }}}
}
