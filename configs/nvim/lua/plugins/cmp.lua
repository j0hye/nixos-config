local M = {}
-- {
--   "saghen/blink.cmp",
--   name = "blink.cmp",
--   event = { "LspAttach", "InsertCharPre" },
--   version = "v0.*",
--   opts = require("plugins.cmp").blink
-- },
-- {
--   "abecodes/tabout.nvim",
--   name = "tabout",
--   event = "InsertCharPre",
--   opt = true,
--   priority = 1000,
--   opts = require("plugins.cmp").tabout
-- },
M.blink = {
    highlight = {
        use_nvim_cmp_as_default = false,
    },
    nerd_font_variant = "normal",
    accept = { auto_brackets = { enabled = false } },

    -- trigger = { signature_help = { enabled = true } },

    keymap = {
        show = "<C-space>",
        hide = "<C-e>",
        accept = "<C-y>",
        -- select_and_accept = {},
        select_prev = "<C-p>",
        select_next = "<C-n>",

        show_documentation = "<C-space>",
        hide_documentation = "<C-space>",
        scroll_documentation_up = "<C-b>",
        scroll_documentation_down = "<C-f>",

        snippet_forward = "<C-l>",
        snippet_backward = "<C-h>",
    },

    windows = {
        autocomplete = {
            border = "single",
        },
        documentation = {
            border = "single",
        },
    },
}

return M
