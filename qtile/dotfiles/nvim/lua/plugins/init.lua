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
				"flutter-tools",
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

	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			require("flutter-tools").setup({
				debugger = {
					enabled = true,
					run_via_dap = true,
				},
				outline = { auto_open = false },
				decorations = {
					statusline = { device = true, app_version = true },
				},
				widget_guides = { enabled = true },
				dev_log = { enabled = true, open_cmd = "tabedit" },
				lsp = {
					color = {
						enabled = true,
						background = true,
						virtual_text = true,
					},
					settings = {
						showTodos = true,
						renameFilesWithClasses = "prompt",
					},
					capabilities = capabilities,
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function(_, opts)
			require("custom.dap")

			-- Basic debugging keymaps
			vim.keymap.set("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
			vim.keymap.set("n", "<leader>dr", "<cmd>DapContinue<CR>")
			vim.keymap.set("n", "<leader>dl", "<cmd>DapStepOver<CR>")
			vim.keymap.set("n", "<leader>dj", "<cmd>DapStepInto<CR>")
			vim.keymap.set("n", "<leader>dk", "<cmd>DapStepOut<CR>")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
