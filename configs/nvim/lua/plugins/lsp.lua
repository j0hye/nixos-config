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
          disable = { "missing-fields" },
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
