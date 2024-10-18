return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "charludo/projectmgr.nvim",
    lazy = false, -- important!
  },

  {
    "charludo/projectmgr.nvim",
    lazy = false, -- important!
    config = function()
      require("projectmgr").setup {
        -- autogit = {
        --   enabled = true,
        --   command = "git pull --ff-only > .git/fastforward.log 2>&1",
        -- },
        session = { enabled = true, file = ".git/Session.vim" },
      }
    end,
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>op",
        function()
          local peek = require "peek"
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
