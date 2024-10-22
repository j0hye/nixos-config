local M = {}

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

M.tabout = {
  tabkey = '<Tab>',
  backwards_tabkey = '<S-Tab>',
  act_as_tab = true,
  act_as_shift_tab = false,
  default_tab = '<C-t>',
  default_shift_tab = '<C-d>',
  enable_backwards = true,
  completion = false,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = '`', close = '`' },
    { open = '(', close = ')' },
    { open = '[', close = ']' },
    { open = '{', close = '}' },
    { open = '<', close = '>' }
  },
  ignore_beginning = true,
  exclude = {}
}

function M.care()
  require("care").setup({
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

  })

  local ls = require("luasnip")

  vim.keymap.set({ "i", "s" }, "<C-l>", function() ls.jump(1) end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-h>", function() ls.jump(-1) end, { silent = true })

  vim.keymap.set({ "i", "s" }, "<C-ö>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true })

  vim.keymap.set("i", "<C-space>", function()
    require("care").api.complete()
  end)

  vim.keymap.set("i", "<C-y>", "<Plug>(CareConfirm)")
  vim.keymap.set("i", "<C-e>", "<Plug>(CareClose)")
  vim.keymap.set("i", "<C-n>", "<Plug>(CareSelectNext)")
  vim.keymap.set("i", "<C-p>", "<Plug>(CareSelectPrev)")

  vim.keymap.set("i", "<c-f>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(4)
    else
      vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
    end
  end)

  vim.keymap.set("i", "<c-d>", function()
    if require("care").api.doc_is_open() then
      require("care").api.scroll_docs(-4)
    else
      vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
    end
  end)
end

return M
