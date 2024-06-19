local fidget = require('fidget')
local progress = require('fidget.progress')

local function build_cmake_project()
    -- Check if CMakeLists.txt exists in the current directory
    local cmake_file = vim.fn.glob("CMakeLists.txt")
    if cmake_file == "" then
        vim.api.nvim_err_writeln("No CMakeLists.txt found in the current directory.")
        return
    end

    -- Create build directory if it doesn't exist
    local build_dir = "build"
    if vim.fn.isdirectory(build_dir) == 0 then
        vim.fn.mkdir(build_dir)
    end

    -- Create a handle for fidget progress
    local handle = progress.handle.create({
        title = "CMake Build",
        message = "Configuring...",
        percentage = 0,
    })

    -- Run cmake command
    local cmake_cmd = "cmake -S . -B " .. build_dir
    vim.fn.jobstart(cmake_cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            handle:report({
                message = table.concat(data, "\n"),
                percentage = 50,
            })
        end,
        on_stderr = function(_, data)
            handle:report({
                message = table.concat(data, "\n"),
                percentage = 50,
            })
        end,
        on_exit = function(_, exit_code)
            if exit_code ~= 0 then
                handle:report({
                    message = "CMake configuration failed.",
                    percentage = 100,
                })
                handle:finish()
                return
            end

            -- Run make command if cmake succeeds
            local make_cmd = "cmake --build " .. build_dir .. " -j16"
            handle:report({
                message = "Building...",
                percentage = 75,
            })
            vim.fn.jobstart(make_cmd, {
                stdout_buffered = true,
                on_stdout = function(_, data)
                    handle:report({
                        message = table.concat(data, "\n"),
                        percentage = 90,
                    })
                end,
                on_stderr = function(_, data)
                    handle:report({
                        message = table.concat(data, "\n"),
                        percentage = 90,
                    })
                end,
                on_exit = function(_, exit_code)
                    if exit_code == 0 then
                        handle:report({
                            message = "Build completed successfully.",
                            percentage = 100,
                        })
                    else
                        handle:report({
                            message = "Build failed.",
                            percentage = 100,
                        })
                    end
                    handle:finish()
                end,
            })
        end,
    })
end

-- Create a command to trigger the build function
vim.api.nvim_create_user_command('BuildCMake', build_cmake_project, {})



function RunProgramInFloatingWindow()
    -- Define the directory where the program is built
    local build_dir = "build"

    -- Search for executable files in the build directory
    local program_cmd
    local files = vim.fn.readdir(build_dir)
    for _, file in ipairs(files) do
        local full_path = build_dir .. '/' .. file
        -- Check if the file is executable
        if vim.fn.executable(full_path) == 1 then
            program_cmd = full_path
            break
        end
    end

    -- If no executable files found, show error message
    if not program_cmd then
        vim.api.nvim_err_writeln("No executable file found in the build directory.")
        return
    end

    -- Define the size of the floating window
    local width = 80
    local height = 20

    -- Create a scratch buffer for the program output
    local buf = vim.api.nvim_create_buf(false, true)

    -- Get the current UI dimensions
    local ui = vim.api.nvim_list_uis()[1]

    -- Calculate the position of the floating window
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((ui.width - width) / 2),
        row = math.floor((ui.height - height) / 2),
        anchor = 'NW',
        style = 'minimal',
    }

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Define the function to close the floating window locally
    local function close_floating_window()
        vim.api.nvim_win_close(win, true)
    end

    -- Set key mappings to close the floating window with any key
    local keymaps = {'<esc>', '<CR>', 'q', '<space>'}
    for _, key in ipairs(keymaps) do
        vim.api.nvim_buf_set_keymap(buf, 'n', key, '', {
            noremap = true,
            silent = true,
            callback = close_floating_window
        })
    end


    -- Run the program and capture its output
    local job_id = vim.fn.jobstart(program_cmd, {
        on_stdout = function(_, data)
            -- Iterate over each line of the program's output
            for _, line in ipairs(data) do
                -- Convert each line to string and set it to buffer
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, {tostring(line)})
            end
        end,
        on_stderr = function(_, data)
            -- Iterate over each line of the program's error output
            for _, line in ipairs(data) do
                -- Convert each line to string and set it to buffer
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, {tostring(line)})
            end
        end,
        on_exit = function(_, exit_code)
            if exit_code ~= 0 then
                vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"Program exited with error code: " .. exit_code})
            end
        end,
    })

    -- Check if the job was successfully started
    if job_id <= 0 then
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, {"Failed to start the program."})
    end
end



-- Function to jump to a buffer matching partial name
local function jump_to_buffer(partial_name)
    vim.cmd('b ' .. partial_name)
end

_G.jump_to_buffer = jump_to_buffer
