-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
    renderer = {
        group_empty = true,
    },
    actions = {
        open_file = {
--[[             quit_on_open = true, ]]
        },
    },
    open_on_tab = true,
})


