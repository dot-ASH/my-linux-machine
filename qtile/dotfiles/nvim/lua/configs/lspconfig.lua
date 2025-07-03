-- load defaults
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local nvlsp = require("nvchad.configs.lspconfig")

local servers = { "ts_ls", "tailwindcss", "cssls", "dartls", "svelte" }

-- Setup loop
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

-- Other LSPs
lspconfig.pyright.setup({
	on_attach = nvlsp.on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

lspconfig.gopls.setup({
	on_attach = nvlsp.on_attach,
	capabilities = nvlsp.capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

-- lspconfig.ts_ls.setup({
-- 	on_attach = function(client, bufnr)
-- 		client.server_capabilities.documentFormattingProvider = false
-- 		nvlsp.on_attach(client, bufnr)
-- 	end,
-- 	on_init = nvlsp.on_init,
-- 	capabilities = nvlsp.capabilities,
-- 	cmd = { "typescript-language-server", "--stdio" },
-- 	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
-- 	root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
-- })
--
lspconfig.ts_ls.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		nvlsp.on_attach(client, bufnr) -- Keep other NvChad LSP functionality
	end,
	on_init = nvlsp.on_init,
	capabilities = nvlsp.capabilities,
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
})
