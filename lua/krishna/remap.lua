local m = require("mapx").setup({
    global = true,
    whichkey = false,
})

vim.g.mapleader = " "

-- remap jj to escape
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- NvimTree
nnoremap("<leader>pv", ":NvimTreeFocus<CR>")
nnoremap("<leader>pc", ":NvimTreeClose<CR>")
nnoremap("<leader>pr", ":NvimTreeRefresh<CR>")

-- Trouble
nnoremap("<leader>t", ":Trouble<CR>")

-- Sad
nnoremap("<leader>s", ":Sad<CR>")

-- Undotree
nnoremap("<leader>u", ":UndotreeToggle<CR>")

-- Neogit
nnoremap("<leader>G", ":Neogit<CR>")

-- Yanky
noremap("<leader>y", [["+y]], "silent")
noremap("<leader>p", [["+p]], "silent")
xnoremap("p", "<Plug>(YankyPutAfter)")
xnoremap("P", "<Plug>(YankyPutBefore)")
xnoremap("gp", "<Plug>(YankyGPutAfter)")
xnoremap("gP", "<Plug>(YankyGPutBefore)")

nnoremap("<c-p>", "<Plug>(YankyPreviousEntry)")
nnoremap("<c-n>", "<Plug>(YankyNextEntry)")

-- Indentation in visual mode
xnoremap("<", "<gv")
xnoremap(">", ">gv")

-- Terminal mode
tnoremap("<Esc>", [[<C-\><C-n>]])

-- Navigation in normal mode
nnoremap("<C-Up>", "<Esc><C-w><up>")
nnoremap("<C-Down>", "<Esc><C-w><down>")
nnoremap("<C-Left>", "<Esc><C-w><left>")
nnoremap("<C-Right>", "<Esc><C-w><right>")

-- Split and term
nnoremap("<F5>", ":set splitright<cr>:vs<cr><C-Right><Esc>:term<cr>i")

-- Telescope
nnoremap("<leader>fs", "<CMD>Telescope live_grep<CR>")
nnoremap("<leader>ff", "<CMD>Telescope find_files<CR>")
nnoremap("<leader>gg", "<CMD>Telescope git_files<CR>")
nnoremap("<leader>gs", "<CMD>Telescope git_status<CR>")

-- ASToggle
nnoremap("<leader>as", ":ASToggle<CR>")

-- Scrolling
nnoremap("j", "gj")
nnoremap("k", "gk")
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")

-- Tagbar
nnoremap("<leader>c", ":TagbarToggle<CR>")

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
nnoremap("<leader>ha", mark.add_file)
nnoremap("<leader>hs", ui.toggle_quick_menu)
nnoremap("<leader>hh", ":Telescope harpoon marks<CR>")

-- Tabs and buffers
nnoremap("<leader>bc", ":tabnew<CR>:NvimTreeFocus<CR>")
nnoremap("<leader>bx", ":bd<CR>")
nnoremap("<leader>bp", ":bp<CR>")
nnoremap("<leader>bn", ":bn<CR>")
nnoremap("<leader>bb", ":Telescope buffers<CR>")
nnoremap("<leader>b", ':lua jump_to_buffer(vim.fn.input("Buffer: "))<CR>', { silent = true })

-- CMake and program execution
nnoremap("<M-l>", "<cmd>MakeitOpen<CR>")
nnoremap("<M-r>", "<cmd>MakeitRedo<CR>")
nnoremap("<M-x>", "<cmd>MakeitBuild<CR>")
nnoremap("<M-t>", "<cmd>MakeitToggleResults<CR>")
-- nnoremap("<C-b>", ":BuildGeneric<CR>")
-- nnoremap("<C-r>", ":RunGeneric<CR>")
-- nnoremap("<M-e>", ":copen<CR>")
-- nnoremap("<M-c>", ":cclose<CR>")
-- nnoremap("<M-n>", ":cnext<CR>")
-- nnoremap("<M-p>", ":cprev<CR>")

-- ROS2
nnoremap("<leader>m", ":Telescope ros2-nvim topic_telescope<CR>")

-- TodoTelescope
nnoremap("<leader>l", ":TodoTelescope<CR>")

-- Treesitter toggle
nnoremap("<S-Tab>", "<cmd>lua require('treesj').toggle()<cr>", { silent = true })

-- SSR
nnoremap("<leader>Sr", function() require("ssr").open() end)

-- Copilot and CopilotChat
-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<leader>cc', "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>zca', "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ct', "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })

-- Visual mode mappings
vim.api.nvim_set_keymap('v', '<leader>cc', "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>ca', "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>ct', "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })

-- TSHT
nnoremap("<C-U>", "<CMD>lua require('tsht').nodes()<CR>")


-- Lspsaga
vim.cmd [[ cnoreabbrev fterm Lspsaga term_toggle]]

