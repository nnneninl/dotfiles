return {
	-- neovim/nvim-lspconfig {{{
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
			"mfussenegger/nvim-lint",
			"saghen/blink.cmp",
		},
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")
			local servers = {
				"astro",
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				"gopls",
				"html",
				"jdtls",
				"jsonls",
				"marksman",
				"pyright",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				"ts_ls",
			}

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = { " " },
			})

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
				})
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						runtime = { "LuaJIT" },
						workspace = { checkThirdParty = false },
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp", { clear = true }),
				callback = function(e)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = e.buf, desc = desc })
					end

					map("n", "<LEADER>d", "<CMD>lua vim.diagnostic.open_float()<CR>", "Show current line diagnostics.")
					map(
						"n",
						"[d",
						"<CMD>lua vim.diagnostic.jump({ count = -1, float = true })<CR>",
						"Go to previous diagnostic."
					)
					map(
						"n",
						"]d",
						"<CMD>lua vim.diagnostic.jump({ count = 1, float = true })<CR>",
						"Go to next diagnostic."
					)
					map("n", "<LEADER>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", "Open code actions.")
					map("n", "<S-k>", "<CMD>lua vim.lsp.buf.hover()<CR>", "Show documentation for word under cursor.")
					map("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", "Go to definition.")
					map("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", "Go to declaration.")
					map("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", "Show implementations.")
					map("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", "Show references.")
					map("n", "gt", "<CMD>lua vim.lsp.buf.type_definition()<CR>", "Show type definition.")
					map("n", "<LEADER>rn", "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename with LSP.")
					map("n", "<C-s>", "<CMD>lua vim.lsp.buf.format()<CR>", "Format with LSP.")
				end,
				desc = "Assign specific keymaps when lsp attaches.",
			})
		end,
	},
	-- }}}
	-- williamboman/mason.nvim {{{
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		keys = {
			{
				"<LEADER>mm",
				"<CMD>Mason<CR>",
				desc = "Open Mason.",
			},
		},
		config = function()
			local mr = require("mason-registry")
			local ensure_installed = function()
				for _, pkg_name in ipairs({
					-- formatter
					"prettierd",
					"stylua",
					-- linter
					"eslint_d",
					"golangci-lint",
					-- lsp
					"astro-language-server",
					"bash-language-server",
					"clangd",
					"css-lsp",
					"dockerfile-language-server",
					"gopls",
					"html-lsp",
					"jdtls",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"pyright",
					"rust-analyzer",
					"svelte-language-server",
					"tailwindcss-language-server",
					"typescript-language-server",
				}) do
					local pkg = mr.get_package(pkg_name)
					if not pkg:is_installed() then
						pkg:install()
					end
				end
			end

			require("mason").setup({
				ui = {
					icons = {
						package_installed = "[*]",
						package_pending = "[~]",
						package_uninstalled = "[x]",
					},
				},
			})

			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	-- }}}
	-- stevearc/conform.nvim {{{
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters = {
					rustfmt = {
						command = "/usr/bin/rustfmt",
					},
				},
				formatters_by_ft = {
					astro = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					lua = { "stylua" },
					markdown = { "prettierd" },
					rust = { "rustfmt" },
					svelte = { "prettierd" },
					typescript = { "prettierd" },
					typescriptreact = { "prettierd" },
				},
				format_on_save = {
					async = false,
					lsp_fallback = true,
				},
			})
		end,
	},
	-- }}}
	-- mfussenegger/nvim-lint {{{
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				go = { "golangcilint" },
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				svelte = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("linting", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
				desc = "Run linter.",
			})
		end,
	},
	-- }}}
}
