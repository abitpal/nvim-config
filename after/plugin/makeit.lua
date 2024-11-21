require('makeit').setup({
    output = "terminal", -- This ensures output is shown in a terminal
    terminal = {
        position = "float", -- Display the output in a floating window
        float_opts = {
            border = "rounded", -- Adds a rounded border
            width = 0.8,        -- Set width as 80% of the screen
            height = 0.8,       -- Set height as 80% of the screen
        },
    },
    default_target = "run", -- Default target to run your script
})

