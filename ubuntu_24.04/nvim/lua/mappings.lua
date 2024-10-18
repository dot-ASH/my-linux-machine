require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Undo in insert mode
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode", noremap = true, silent = true })

map("i", "<C-S-z>", "<C-o><cmd>redo<CR>", { desc = "Redo in insert mode", noremap = true, silent = true })

-- Remove word with Ctrl+Backspace
map("i", "<C-BS>", "<C-w>", { desc = "Delete word backward", noremap = true, silent = true })

map("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Toggle NvimTree" })

map("n", "<leader>q", "<leader>x", { desc = "Close Buffer" })

-- Projects
map("n", "<leader>fp", "<CMD> ProjectMgr<CR>", { desc = "Open Projects" })

-- Insert Navigation

map("i", "<C-CR>", "<Esc>o", { desc = "New Line in Insert Mode", noremap = true, silent = true })

map("i", "<C-v>", "<Esc>v")

map("i", "<A-Up>", "<CMD>m -2<CR>")

map("i", "<A-Down>", "<CMD>m +1<CR>")
