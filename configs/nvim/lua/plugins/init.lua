local conf_path = vim.fn.stdpath "config" --[[@as string]]

local plugins = {
  -- colorschemes
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000,
    name = "catppuccin",
    init = function()
      vim.cmd.colorscheme "catppuccin"
    end,
    opts = {
      transparent_background = true,
      compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      compile = true,
      flavour = "mocha",
      integrations = {
        cmp = true,
        treesitter = true,
        mason = true,
        native_lsp = {
          enabled = true,
          inlay_hints = {
            background = true,
          },
        },
        mini = {
          enabled = true,
          indentscope_color = "lavender",
        },
      },

    },
  },
  --- Mini stuffs
  {
    "echasnovski/mini.nvim",
    name = "mini",
    version = false,
    keys = function()
      require("mappings").mini()
    end,
    init = function()
      package.preload["nvim-web-devicons"] = function()
        package.loaded["nvim-web-devicons"] = {}
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
    event = function()
      if vim.fn.argc() == 0 then
        return "VimEnter"
      else
        return { "InsertEnter", "LspAttach" }
      end
    end,

    config = function()
      local mini_config = require "plugins.mini_nvim"
      local mini_modules = {
        "icons",
        "comment",
        "starter",
        "pairs",
        "ai",
        "surround",
        "files",
        "hipatterns",
        "bufremove",
        "pick",
        "move",
        "indentscope",
        "extra",
        "visits",
        "clue",
        "notify",
        "git",
        "diff",
      }
      for _, module in ipairs(mini_modules) do
        require("mini." .. module).setup(mini_config[module])
      end
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "nix", "lua", "vimdoc", "rust", "go", "astro", "json", "toml", "markdown" },
        highlight = {
          enable = true,
          use_languagetree = true,
        },

        indent = { enable = true },
      }
    end,
  },

  --- Completion menu stuffs
  {
    name = "autocmp",
    dir = conf_path,
    event = { "LspAttach", "InsertCharPre" },
    dependencies = {
      "max397574/care.nvim",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        keys = function()
          return {}
        end,
      },
      {
        "abecodes/tabout.nvim",
        lazy = false,
        opt = true,
        priority = 1000,
        event = "InsertCharPre",
      },
    },
    config = require("plugins.cmp").care()
  },



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
  {
    "Bekaboo/dropbar.nvim",
    name = "dropbar",
    keys = {
      require("mappings").map({ "n" }, "<leader>p", function()
        require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count)
      end, "Toggle dropbar menu"),
    },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("dropbar").setup()
    end,
  },

  --- lsp stuffs
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    dependencies = {
      { "j-hui/fidget.nvim",       opts = {} },
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      {
        "folke/lazydev.nvim",
        ft = "lua",
        dependencies = { "Bilal2453/luvit-meta", lazy = true },
        opts = {
          library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
          integrations = {
            lspconfig = true,
            cmp = false,
          },
        },
      },
    },
    event = { "BufReadPost", "BufNewFile" },
    keys = function()
      require("mappings").lsp()
    end,
    config = function()
      require "plugins.lsp"
    end,
  },

  {
    name = "options",
    event = "VeryLazy",
    dir = conf_path,
    config = function()
      require("opts").final()
      require("mappings").general()
      require("mappings").misc()
      require("modules").autocmds()
    end,
  },
}

require("lazy").setup(plugins, {
  concurrency = 4,
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { "catppuccin" },
  },
  dev = {
    path = vim.env.NVIM_DEV,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = false,
    rtp = {
      reset = false,
      disabled_plugins = {
        "osc52",
        "parser",
        "gzip",
        "netrwPlugin",
        "health",
        "man",
        "matchit",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "shadafile",
        "spellfile",
        "editorconfig",
      },
    },
  },
  ui = {
    border = "single",
    title = "lazy.nvim",
  },
})
