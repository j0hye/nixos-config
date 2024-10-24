local M = {}

M.conform = {
    formatters_by_ft = {
        lua = { "stylua" },
        nix = { "alejandra" },
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
    },
}

function M.lspconfig()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local servers = {
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

    require("mason").setup {
        ui = {
            border = "single",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
        -- "stylua",
    })

    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    }
end

function M.not_in_mason()
    -- LSPs not in Mason
    require("lspconfig").nixd.setup {
        cmd = { "nixd" },
        settings = {
            nixd = {
                nixpkgs = {
                    -- expr = "import <nixpkgs> { }",
                    expr = { 'import (builtins.getFlake "/home/johye/nixos").inputs.nixpkgs { }' },
                },
                formatting = {
                    command = { "alejandra" },
                },
                options = {
                    nixos = {
                        expr = 'import (builtins.getFlake "/home/johye/nixos").nixosConfigurations.wsl.options',
                    },
                    -- home_manager = {
                    --   expr = "import (builtins.getFlake \"/home/johye/nixos\").homeConfigurations.johye.options",
                    -- },
                },
            },
        },
    }
end

return M
