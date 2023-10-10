require("mapx").setup({
	global = true,
})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")
noremap("<leader>y", [["+y]], "silent")
noremap("<leader>p", [["+p]], "silent")

xnoremap("<", "<gv")
xnoremap(">", ">gv")

nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")

