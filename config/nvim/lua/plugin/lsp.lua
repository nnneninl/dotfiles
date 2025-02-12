return {
	-- neovim/nvim-lspconfig {{{
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
			"mfussenegger/nvim-lint",
		},
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local servers = {
				"bashls",
				"clangd",
				"cssls",
				"eslint",
				"dockerls",
				"gopls",
				"html",
				"htmx",
				"jsonls",
				"marksman",
				"pyright",
				"rust_analyzer",
				"svelte",
				"tailwindcss",
				"templ",
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

			lspconfig.svelte.setup({
				capabilities = capabilities,
				---@diagnostic disable-next-line: unused-local
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						group = vim.api.nvim_create_autocmd("svelte", { clear = true }),
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
						pattern = { "*.js", "*.ts" },
					})
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp", { clear = true }),
				callback = function(e)
					local map = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = e.buf, desc = desc })
					end

					map("n", "<LEADER>d", "<CMD>lua vim.diagnostic.open_float()<CR>", "Show current line diagnostics.")
					map("n", "[d", "<CMD>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic.")
					map("n", "]d", "<CMD>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic.")
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
	--}}}
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
					"prettier",
					"stylua",
					-- linter
					"eslint-lsp",
					"golangci-lint",
					-- lsp
					"bash-language-server",
					"dockerfile-language-server",
					"clangd",
					"css-lsp",
					"gopls",
					"html-lsp",
					"htmx-lsp",
					"json-lsp",
					"lua-language-server",
					"marksman",
					"pyright",
					"rust-analyzer",
					"svelte-language-server",
					"tailwindcss-language-server",
					"templ",
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
	--}}}
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
					css = { "prettier" },
					html = { "prettier" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					lua = { "stylua" },
					markdown = { "prettier" },
					rust = { "rustfmt" },
					svelte = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
				},
				format_on_save = {
					async = false,
					lsp_fallback = false,
				},
			})
		end,
	},
	--}}}
	-- mfussenegger/nvim-lint {{{
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				go = { "golangcilint" },
			}

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("linting", { clear = true }),
				callback = function()
					require("lint").try_lint()
				end,
				pattern = { "*.go" },
				desc = "Run linter.",
			})
		end,
	},
	--}}}
}
