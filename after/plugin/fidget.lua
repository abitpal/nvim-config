require('fidget').setup({
    notification = {
      window = {
        winblend = 0,
      },
    },
})

-- vim.cmd [[
--
--     augroup fidget-highlights
--   autocmd!
--   autocmd ColorScheme * highlight FidgetTitle guifg=#b48ead
--   autocmd ColorScheme * highlight FidgetTask guifg=#d8dee9
-- augroup END
--     ]]
