-- Import required modules
local cmp = require('cmp')
local luasnip = require('luasnip')
local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')
local lspkind = require('lspkind')

vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight NoiceBorder guifg=white guibg=#1f2335]]



local border = "rounded" 

-- LSP settings (for overriding per client)
local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


-- ========================
-- Completion Configuration
-- ========================
cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- Use LuaSnip for snippet expansion
        end,
    },
    mapping = {
        -- Confirm completion with Enter
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- Trigger completion menu with Ctrl+Space
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Navigate snippet placeholders
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

        -- Scroll through completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    },
    sources = {
        { name = 'nvim_lsp' }, -- LSP completions
        { name = 'luasnip' }, -- Snippet completions
        { name = 'buffer' },  -- Buffer words
        { name = 'path' },    -- File paths
        per_filetype = {
            codecompanion = { "codecompanion" },
        }
    },
    window = {
        completion = {
            border = border,  -- Apply the custom border to the completion menu
        },
        documentation = {
            border = border,  -- Apply the custom border to the documentation window
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50,   -- prevent the popup from showing more than 50 characters
            ellipsis_char = '...', -- truncate long labels with ellipsis
            before = function(entry, vim_item)
                -- You can customize vim_item here before it gets formatted by lspkind
                vim_item.menu = entry.source.name
                return vim_item
            end,
        }),
    },
})

-- ================================
-- LSP Zero Default Configuration
-- ================================
lsp_zero.on_attach(function(client, bufnr)
    -- Set default LSP keymaps
    lsp_zero.default_keymaps({ buffer = bufnr, preserve_mappings = false })

    local opts = { buffer = bufnr }

    -- Formatting with `gq`
    vim.keymap.set({ 'n', 'x' }, 'gq', function()
        vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
    end, opts)

    -- Telescope LSP mappings
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_implementations<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_incoming_calls<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>Telescope lsp_outgoing_calls<cr>', opts)

    -- Hover and actions
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Document and workspace symbols
    vim.keymap.set('n', '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>', opts)
    vim.keymap.set('n', '<leader>ws', '<cmd>Telescope lsp_workspace_symbols<cr>', opts)
end)

-- Set LSP diagnostic sign icons
lsp_zero.set_sign_icons({
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '»',
})

-- ===================
-- Mason Configuration
-- ===================
require('mason').setup({}) -- Ensure Mason is initialized
require('mason-lspconfig').setup({
    ensure_installed = { "clangd", "cmake", "rust_analyzer", "pylsp" }, -- Auto-install these servers
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

-- ==========================
-- LSP Specific Configuration
-- ==========================

-- Python: pyright settings
lspconfig.pyright.setup({
    handlers = handlers,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true
            }
        }
    }
})

-- Python: pylsp settings
lspconfig.pylsp.setup({
    handlers = handlers,
    settings = {
        pylsp = {
            plugins = {
                ruff = {  -- Enable ruff for linting
                    enabled = false,
                    extendSelect = {'E', 'F'},  -- Optional: specify which checks to enable in ruff
                },
                mypy = {  -- Enable mypy for type checking
                    enabled = false,
                    live_mode = true,  -- Enable live mode to run mypy on the fly
                },
                pycodestyle = {
                    enabled = false,  -- Disable pycodestyle since ruff handles this
                },
                pylint = {
                    enabled = false,  -- Disable pylint since ruff covers most of it
                },
                flake8 = {
                    enabled = false,  -- Disable flake8 since ruff includes its checks
                },
                pyflakes = {
                    enabled = false,  -- Disable pyflakes as ruff replaces it
                },
                mccabe = {
                    enabled = true,  -- Disable mccabe (complexity checker)
                },
                yapf = {
                    enabled = false,  -- Disable yapf, as black is already set up
                },
                autopep8 = {
                    enabled = true,  -- Disable autopep8
                },
                pydocstyle = {
                    enabled = false,  -- Disable pydocstyle, unnecessary with ruff
                }
            }
        },
    },
})

-- Rust: rust-analyzer settings
local rust_settings_path = vim.fn.getcwd() .. "/rust-analyzer.json"
if vim.fn.filereadable(rust_settings_path) == 1 then
    local settings = vim.fn.json_decode(vim.fn.readfile(rust_settings_path))
    lspconfig.rust_analyzer.setup({ settings = settings })
end

-- Setup conform.nvim
require('conform').setup({
    formatters_by_ft = {
        python = { "black" }, -- Use Black for Python
        -- Add other formatters as needed for different languages
    },
    format_on_save = { -- Enable format on save
        timeout_ms = 5000, -- Timeout for formatting
    },
})

-- Keymap for manual formatting
vim.keymap.set('n', '<leader>fm', function()
    require('conform').format({ lsp_fallback = true }) -- Fallback to LSP if no formatter is available
end, { desc = "Format code" })



