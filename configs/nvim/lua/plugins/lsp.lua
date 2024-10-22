local capabilities = vim.lsp.protocol.make_client_capabilities()
local servers = {
  nil_ls = {},
  lua_ls = {
    filetypes = { "lua" },
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          globals = { "vim" },
        },
        format = {
          defaultConfig = {
          },
        },
        hint = {
          enable = true,
        },
      },
    },
  },
}

require('mason').setup({
  ui = {
    border = "single",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  -- "stylua",
})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

require('mason-lspconfig').setup {
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}


--
-- capabilities.textDocument.completion.completionItem = {
--   documentationFormat = { "markdown", "plaintext" },
--   snippetSupport = true,
--   preselectSupport = true,
--   insertReplaceSupport = true,
--   labelDetailsSupport = true,
--   deprecatedSupport = true,
--   commitCharactersSupport = true,
--   tagSupport = { valueSet = { 1 } },
--   resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   },
-- }
--
-- local lspconfig = require "lspconfig"
--
-- lspconfig.lua_ls.setup {
--   filetypes = { "lua" },
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--       },
--       completion = {
--         callSnippet = "Replace",
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--       format = {
--         defaultConfig = {
--         },
--       },
--       hint = {
--         enable = true,
--       },
--     },
--   },
-- }
--
-- lspconfig.bashls.setup {}
--
-- lspconfig.pylsp.setup {
--   settings = {
--     pylsp = {
--       plugins = {
--         jedi_completion = {
--           include_params = true,
--         },
--       },
--     },
--   },
-- }
--
-- lspconfig.ts_ls.setup {
--   cmd = { "typescript-language-server", "--stdio" },
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--   init_options = {
--     hostInfo = "neovim",
--   },
--   single_file_support = true,
--   settings = {
--     completions = {
--       completeFunctionCalls = true,
--     },
--   },
-- }
--
-- lspconfig.nil_ls.setup {}
--
-- lspconfig.zls.setup {}
