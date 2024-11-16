require("nvchad.mappings")

-- Custom Key Mappings
local map = vim.keymap.set

-- Normal Mode Mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
map("n", "<leader>E", "<cmd>NvimTreeFocus<CR>", { desc = "Focus NvimTree" })
map("n", "<leader>q", ":q<CR>", { desc = "Close a Window", noremap = true, silent = true })
map("n", "<A-Up>", "<CMD>m -2<CR>", { desc = "Move line up" })
map("n", "<A-Down>", "<CMD>m +1<CR>", { desc = "Move line down" })
map("n", "<C-z>", "<nop>", { desc = "Disable Ctrl+Z in normal mode", noremap = true, silent = true })
map("v", "<S-Down>", "<nop>", { desc = "Shift Down Disable", noremap = true, silent = true })
map("n", "<C-S-v>", '"0p', { desc = "Paste from yank register", noremap = true, silent = true })
map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "new buffer" })
map("n", "<leader>ba", "<cmd>bufdo bd<CR>", { desc = "close all buffer" })
map("n", "<leader>v", "<C-w>v", { desc = "Open window vertically" })

-- Project Management
map("n", "<leader>fp", "<CMD> ProjectMgr<CR>", { desc = "Open Projects" })

-- Insert Mode Mappings
map("i", "jj", "<ESC>", { desc = "Quick escape" })
map("i", "<C-z>", "<C-o>u", { desc = "Undo in insert mode", noremap = true, silent = true })
map("i", "<C-S-z>", "<C-o><cmd>redo<CR>", { desc = "Redo in insert mode", noremap = true, silent = true })
map("i", "<C-BS>", "<C-w>", { desc = "Delete word backward", noremap = true, silent = true })
map("i", "<C-CR>", "<Esc>o", { desc = "New line in insert mode", noremap = true, silent = true })
map("i", "<C-s>", "<Esc><Cmd>w<CR>", { desc = "Save file", noremap = true, silent = true })
map("i", "<C-Delete>", "<Esc>ldei", { desc = "Delete word forward", noremap = true, silent = true })
map("i", "<C-v>", "<Esc>v", { desc = "Visual mode in insert mode" })
map("i", "<A-Up>", "<CMD>m -2<CR>", { desc = "Move line up in insert mode" })
map("i", "<A-Down>", "<CMD>m +1<CR>", { desc = "Move line down in insert mode" })
map("i", "<C-S-i>", "<Esc><leader>fm", { desc = "Format file" })
map("i", "<C-S-v>", '<C-o>"0p', { desc = "Paste from yank register in insert mode", noremap = true, silent = true })
