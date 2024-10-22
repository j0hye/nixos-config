local conf_path = vim.fn.stdpath "config" --[[@as string]]
local plugins = {
  -- Mini plugins 
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

  -- Treesitter
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

  -- Completion
  {
    "max397574/care.nvim",
    name = "care",
    dependencies = {
      {
        "abecodes/tabout.nvim",
        dependencies = {
          {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            config = function()
              return {}
            end,
          },
        },
        lazy = false,
        opt = true,
        priority = 1000,
        event = "InsertCharPre",
        opts = {},
      },
      "max397574/care-cmp",
    },
    config = require("plugins.cmp").care(),
    opts = {
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
    },
  },
  -- LSP and Mason setup
  {
    "neovim/nvim-lspconfig",
    name = "lspconfig",
    dependencies = {
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
            cmp = true,
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

  -- Options, mappings and autos
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
  -- concurrency = 4,
  -- pkg = {
  --   sources = {
  --     "lazy",
  --   },
  -- },
  -- defaults = {
  --   lazy = false,
  -- },
  -- install = {
  --   colorscheme = { "catppuccin" },
  -- },
  -- dev = {
  --   path = vim.env.NVIM_DEV,
  -- },
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
