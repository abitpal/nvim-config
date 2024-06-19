-- Enable termguicolors
vim.opt.termguicolors = true

require("bufferline").setup{
    options = {
        hover = {
            enabled = true,
            delay = 150,
            reveal = {'close'}
        },
        separator_style = "thick",
        -- style_preset = bufferline.style_preset.no_italic,
        numbers = function(opts)
            return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or ""
            return " " .. icon .. count
        end,
        enforce_regular_tabs = true
    },
}

