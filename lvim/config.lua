-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

require"user.options"
require"user.plugins"
require"user.colorscheme"
require"user.keymap"
-- vim.cmd [[inoremap <C-Z> <Esc>ui]]
-- lvim.autocommands = {

--   {
--     { "ColorScheme" },
--     {
--       pattern = "*",
--       callback = function()
--         vim.api.nvim_set_hl(0, "hlgroup", { bg = "#ffffff", underline = false, bold = true })
--       end,
--     },
--   },
-- }


