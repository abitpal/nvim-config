-- Utilities for creating configurations
local util = require "formatter.util"

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require("formatter.filetypes.lua").stylua,

            -- You can also define your own configuration
            function()
                -- Supports conditional formatting
                if util.get_current_buffer_file_name() == "special.lua" then
                    return nil
                end

                -- Full specification of configurations is down below and in Vim help
                -- files
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
                        "-",
                    },
                    stdin = true,
                }
            end
        },

        python = {
            function()
                local util = require("formatter.util")
                return {
                    exe = "black",
                    args = { "-q", "--stdin-filename", util.escape_path(util.get_current_buffer_file_name()), "-" },
                    stdin = true,
                }
            end
        },

        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = { "--edition 2021" },
                    stdin = true,
                }
            end
        },

        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = { "-assume-filename=" .. util.get_current_buffer_file_name(), "-style=file" },
                    stdin = true,
                }
            end
        },

        css = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },

        java = {
            function()
                return {
                    exe = "google-java-format",
                    args = {
                        "--aosp",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--replace"
                    },
                    stdin = true
                }
            end
        },

        json = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },

        yaml = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },

        markdown = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },

        html = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },

        javascript = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },

        typescript = {
            function()
                return {
                    exe = "prettier",
                    args = { "--stdin-filepath", util.get_current_buffer_file_path() },
                    stdin = true,
                }
            end
        },



        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
