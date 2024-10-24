local M = {}

M.care = {
    ui = {
        menu = {
            border = "single",
        },
        docs_view = {
            border = "single",
        },
    },
    snippet_expansion = function(body)
        require("luasnip").lsp_expand(body)
    end,
}

return M
