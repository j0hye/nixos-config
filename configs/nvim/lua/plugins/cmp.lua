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
    { open = '{', close = '}' }
  },
  ignore_beginning = true,
  exclude = {}
}

return M
