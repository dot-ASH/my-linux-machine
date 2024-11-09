local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
  sources = {
    -- Add your preferred sources here
    -- Example sources:
    require "none-ls.diagnostics.eslint_d",
    -- require "none-ls.formatting.eslint_d",
    require "none-ls.code_actions.eslint_d",
    -- require "none-ls-shellcheck.diagnostics",
    -- require "none-ls-shellcheck.code_actions",
    -- null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.diagnostics.shellcheck,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
    end
  end,
}

return opts
