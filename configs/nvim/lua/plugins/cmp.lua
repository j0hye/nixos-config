deps.add {
    source = "saghen/blink.cmp",
    checkout = "v0.3.1", -- check releases for latest tag
    depends = {
        "rafamadriz/friendly-snippets",
        "abecodes/tabout.nvim",
    },
}
deps.later(function()
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
            use_nvim_cmp_as_default = true,
        },
        nerd_font_variant = "normal",
    }
    require("tabout").setup {
        tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
            { open = "'", close = "'" },
            { open = '"', close = '"' },
            { open = "`", close = "`" },
            { open = "(", close = ")" },
            { open = "[", close = "]" },
            { open = "{", close = "}" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
    }
end)
