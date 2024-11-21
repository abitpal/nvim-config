require("dashboard").setup{
    theme = "doom",
    hide = {
        statusline = false, -- managed by lualine; avoids conflict
    },
    config = {
        header = vim.split([[
                                                   
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
                            [ Hello Krishna]                          
      ]], "\n"),
        center = {
            { icon = " ", desc = " Find File             ", action = "lua require('telescope.builtin').find_files()", key = "f" },
            { icon = " ", desc = " New File              ", action = "ene | startinsert", key = "n" },
            { icon = " ", desc = " Recent Files          ", action = "lua require('telescope.builtin').oldfiles()", key = "r" },
            { icon = " ", desc = " Find Text             ", action = "lua require('telescope.builtin').live_grep()", key = "g" },
            { icon = " ", desc = " Config                ", action = "lua require('lazyvim.config').config_files()", key = "c" },
            { icon = " ", desc = " Restore Session       ", action = 'lua require("persistence").load()', key = "s" },
            { icon = " ", desc = " Lazy Extras           ", action = "LazyExtras", key = "x" },
            { icon = "󰒲 ", desc = " Lazy                  ", action = "Lazy", key = "l" },
            { icon = " ", desc = " Quit                  ", action = "qa", key = "q" },
        },
        footer = function()
            local stats = require("lazy").stats()
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. (math.floor(stats.startuptime * 100 + 0.5) / 100) .. "ms" }
        end,
    }
}

-- Optionally, auto-close Lazy and reopen on dashboard load
if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
            require("lazy").show()
        end,
    })
end
