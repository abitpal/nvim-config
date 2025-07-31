vim.g.rustaceanvim = {
    -- Plugin configuration
    tools = {
    },
    -- LSP configuration
    server = {
        on_attach = function(client, bufnr)
            -- you can also put keymaps in here
        end,
        default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
                cargo = {
                    allFeatures = true, -- Enable all features in Cargo.toml
                    loadOutDirsFromCheck = true, -- Load output directories from `cargo check`
                },
            },
        },
    },
    -- DAP configuration
    dap = {
    },
}
