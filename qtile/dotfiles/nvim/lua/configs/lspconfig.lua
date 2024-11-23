-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

-- EXAMPLE
local servers = { "ts_ls", "tailwindcss", "cssls", "dartls" }
local nvlsp = require("nvchad.configs.lspconfig")

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

lspconfig.pyright.setup({
	on_attach = nvlsp.on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic", -- Change to "strict" if needed
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})
