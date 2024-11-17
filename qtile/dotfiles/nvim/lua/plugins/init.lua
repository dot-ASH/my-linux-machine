return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = require("configs.conform"),
	},

	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		event = "VeryLazy",
		opts = function()
			return require("configs.null-ls")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"charludo/projectmgr.nvim",
		lazy = false, -- important!
		config = function()
			require("projectmgr").setup({
				session = { enabled = true, file = ".git/Session.vim" },
			})
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"typescript-language-server",
				"tailwindcss-language-server",
				"prettier",
				"js-debug-adapter",
				"stylua",
				"black",
				"pyright",
				"mypy",
			},
		},
	},

	{
		"windwp/nvim-ts-autotag",
		ft = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"html",
		},
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "gcc",
					block = "gbc",
				},
				opleader = {
					line = "gc",
					block = "gb",
				},
				pre_hook = function(ctx)
					local U = require("Comment.utils")
					local ts_utils = require("ts_context_commentstring.utils")
					local ts_internal = require("ts_context_commentstring.internal")

					if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
						local location = ts_utils.get_cursor_location()
						return ts_internal.calculate_commentstring({
							key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
							location = location,
						})
					end
				end,
			})
		end,
		keys = { "gc", "gcc", "gbc" },
		event = "BufRead",
	},

	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		keys = {
			{
				"<leader>op",
				function()
					local peek = require("peek")
					if peek.is_open() then
						peek.close()
					else
						peek.open()
					end
				end,
				desc = "Peek (Markdown Preview)",
			},
		},
		opts = { theme = "dark", app = "browser" },
	},
}
