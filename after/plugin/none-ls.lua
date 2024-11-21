local nullls = require('null-ls')

-- add mypy

nullls.setup({
    sources = {
        -- Adding mypy as a source for diagnostics
        nullls.builtins.diagnostics.mypy,
        nullls.builtins.formatting.black,
        nullls.builtins.diagnostics.ruff
    }
})
