-- local lsp_zero = require('lsp-zero')
--
local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
--     -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = true}),
--
--     -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
--
--     -- Navigate between snippet placeholder
--     ['<C-f>'] = cmp_action.luasnip_jump_forward(),
--     ['<C-b>'] = cmp_action.luasnip_jump_backward(),
--
--     -- Scroll up and down in the completion documentation
--     ['<C-u>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})
--
-- lsp_zero.on_attach(function(client, bufnr)
--   -- see :help lsp-zero-keybindings
--   -- to learn the available actions
--   lsp_zero.default_keymaps({buffer = bufnr})
--   vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
-- end)

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr, preserve_mappings = false})
    local opts = {buffer = bufnr}

    vim.keymap.set({'n', 'x'}, 'gq', function()
        vim.lsp.buf.format({async = false, timeout_ms = 10000})
    end, opts)
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_implementations<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_incoming_calls<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'go', '<cmd>Telescope lsp_outgoing_calls<cr>', {buffer = bufnr})
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<leader>df', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    -- vim.keymap.set('n', '<leader>dt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>', {buffer = bufnr})
    vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_workspace_symbols<cr>', opts)
 
end)

lsp_zero.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {"clangd", "cmake", "rust_analyzer"},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})



