deps.add {
    source = "saghen/blink.cmp",
    checkout = "v0.3.1", -- check releases for latest tag
}
deps.now(function()
    require("blink.cmp").setup {
        -- for keymap, all values may be string | string[]
        -- use an empty table to disable a keymap
        keymap = {
            show = "<C-space>",
            hide = "<C-e>",
            accept = "<C-y>",
            select_prev = { "<C-p>" },
            select_next = { "<C-n>" },
            show_documentation = { "<C-k>" },
            hide_documentation = { "<C-k>" },
            scroll_documentation_up = "<C-b>",
            scroll_documentation_down = "<C-f>",
            snippet_forward = "<C-l>",
            snippet_backward = "<C-h>",
        },
        trigger = {
            signature_help = {
                enabled = true,
            },
        },
        windows = {
            autocomplete = {
                border = "single",
            },
            documentation = {
                border = "single",
            },
            signature_help = {
                border = "single",
            },
        },
        highlight = {
            ns = vim.api.nvim_create_namespace("blink_cmp"),
            use_nvim_cmp_as_default = false,
        },
        nerd_font_variant = "normal",
    }
end)
