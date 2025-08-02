return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    event = "VeryLazy",
    opts = function()
      return require "configs.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "charludo/projectmgr.nvim",
    lazy = false, -- important!
    config = function()
      require("projectmgr").setup {
        session = { enabled = true, file = ".git/Session.vim" },
      }
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
        "gopls",
        "svelte-language-server",
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
      require("Comment").setup {
        toggler = {
          line = "gcc",
          block = "gbc",
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        pre_hook = function(ctx)
          local U = require "Comment.utils"
          local ts_utils = require "ts_context_commentstring.utils"
          local ts_internal = require "ts_context_commentstring.internal"

          if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
            local location = ts_utils.get_cursor_location()
            return ts_internal.calculate_commentstring {
              key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
              location = location,
            }
          end
        end,
      }
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

      require("flutter-tools").setup {
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
      }
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require "custom.dap"

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
      local dap = require "dap"
      local dapui = require "dapui"
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

  {
    "tpope/vim-fugitive",
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup {
        on_attach = function(bufnr)
          local gs = require "gitsigns"

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          -- Preview hunk
          map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })

          -- Blame current line
          map("n", "<leader>gk", function()
            gs.blame_line { full = true }
          end, { desc = "Blame Current Line" })
        end,
      }
    end,
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<C-\\>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })

      vim.keymap.set("i", "<TAB>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
    end,
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup { n_lines = 500 }
      require("mini.surround").setup()
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach", -- Important: Load when LSP attaches
    config = function()
      require("tiny-inline-diagnostic").setup()
      -- Disable ALL virtual text globally (must be before LSP starts)
      vim.diagnostic.config { virtual_text = false }
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble" },
    opts = {}, -- Use default options
    keys = {
      {
        "<leader>cx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle Diagnostics",
      },
      {
        "<leader>cd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Toggle Document Diagnostics",
      },
      {
        "<leader>cq",
        "<cmd>Trouble quickfix toggle<cr>",
        desc = "Toggle Quickfix List",
      },
      {
        "<leader>cl",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Toggle Location List",
      },
      {
        "<leader>cr",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Toggle LSP References",
      },
    },
  },

  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        markdown = { "markdownlint" },
        typescript = { "biomejs" },
        typescriptreact = { "biomejs" },
      }
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
