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

function M.care()
  vim.keymap.set("i", "<C-y>", "<Plug>(CareConfirm)")
  vim.keymap.set("i", "<C-e>", "<Plug>(CareClose)")
  vim.keymap.set("i", "<C-n>", "<Plug>(CareSelectNext)")
  vim.keymap.set("i", "<C-p>", "<Plug>(CareSelectPrev)")

  vim.keymap.set("i", "<C-f>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(4)
    else
      vim.api.nvim_feedkeys(vim.keycode("<C-f>"), "n", false)
    end
  end)

  vim.keymap.set("i", "<C-b>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(-4)
    else
      vim.api.nvim_feedkeys(vim.keycode("<C-b>"), "n", false)
    end
  end)

  vim.keymap.set({ "i", "s" }, "<C-l>", function() require("luasnip").jump(1) end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-h>", function() require("luasnip").jump(-1) end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-ö>", function()
    if require("luasnip").choice_active() then
      require("luasnip").change_choice(1)
    end
  end, { silent = true })
end

return M
