local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate between snippet placeholders
        ['<M-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<M-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
})
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
    ensure_installed = {"clangd", "cmake", "rust_analyzer", "pylsp"},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})


local lspconfig = require('lspconfig')
lspconfig.pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = {'E501', 'E302', 'E303', 'E226', 'E241', 'E704', 'W391', 'W293', 'E116', 'W291', 'E741', 'E305'},
                    maxLineLength = 100
                },
                pylint = {
                    enabled = false
                },
                flake8 = {
                    enabled = false
                },
                pyflakes = {
                    enabled = true
                },
                mccabe = {
                    enabled = false
                },
                yapf = {
                    enabled = false
                },
                autopep8 = {
                    enabled = false
                },
                pydocstyle = {
                    enabled = false
                }
            }
        }
    }
})


local project_settings_path = vim.fn.getcwd() .. "/rust-analyzer.json"
if vim.fn.filereadable(project_settings_path) == 1 then
    local settings = vim.fn.json_decode(vim.fn.readfile(project_settings_path))
    require('lspconfig').rust_analyzer.setup({
        settings = settings
    })
end

