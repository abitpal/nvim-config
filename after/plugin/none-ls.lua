local nullls = require('null-ls')

-- add mypy

nullls.setup({
    sources = {
        -- Adding mypy as a source for diagnostics
        nullls.builtins.diagnostics.mypy.with({
            extra_args = function()
                local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
                return { "--python-executable", virtual .. "/bin/python3" }
            end,
        }),
        nullls.builtins.formatting.black,
        require("none-ls.diagnostics.ruff")
    }
})
