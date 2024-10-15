require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Undo in insert mode
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode" })

map("i", "<C-S-z>", "<C-o><cmd>redo<CR>", { desc = "Redo in insert mode" })

-- Remove word with Ctrl+Backspace
map("i", "<C-BS>", "<C-w>", { desc = "Delete word backward" })

map("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Toggle NvimTree" })


map("n", "<leader>q", "<leader>x", { desc = "Close Buffer" })
