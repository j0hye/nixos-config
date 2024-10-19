return {
    "lazydev.nvim",
    before = function()
        deps.add('folke/lazydev.nvim')
        deps.add('neovim/nvim-lspconfig')
    end,
    ft = "lua",
    after = function()
        local lspconfig = require('lspconfig')
        local server = {
            settings = {
                Lua = {
                    -- workspace = {
                    --     checkThirdParty = false,
                    -- },
                    codeLens = {
                        enable = true,
                    },
                    completion = {
                        callSnippet = 'Replace',
                    },
                    doc = {
                        privateName = { '^_' },
                    },
                    -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    diagnostics = {
                        disable = { 'missing-fields' },
                        globals = {
                            'vim',
                            'describe',
                            'it',
                            'assert',
                            'stub',
                        },
                    },
                    hint = {
                        enable = true,
                    },
                    signatureHelp = {
                        enable = true,
                    },
                },
            },
        }
        lspconfig.lua_ls.setup(server)
        require('lazydev').setup {}
    end,
}
