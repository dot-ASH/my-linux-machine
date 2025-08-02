local options = {
  formatters_by_ft = {
    javascript = { "biome" },
    typescript = { "biome" },
    javascriptreact = { "biome" },
    typescriptreact = { "biome" },
    json = { "biome" },
    html = { "biome" },
    css = { "biome" },
    lua = { "stylua" },
    python = { "black" },
    go = { "gofumpt", "goimports_reviser", "golines" },
  },

  format_on_save = {
    timeout_ms = 3000,
    lsp_fallback = true,
  },
  formatters = {
    biome = {
      command = "biome",
      args = { "format", "--stdin-file-path", "$FILENAME" },
      stdin = true,
    },
  },
}

return options
