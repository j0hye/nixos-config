        deps.add({
            source = 'neovim/nvim-lspconfig'
        })
        deps.later = function()
        -- -- LSP Signature setup
        -- local sig_opts = {
        --     bind = true,
        --     floating_window = true,
        --     handler_opts = { border = 'rounded' },
        --     hint_enable = false,
        --     hint_prefix = {
        --         above = '↙ ', -- when the hint is on the line above the current line
        --         current = '← ', -- when the hint is on the same line
        --         below = '↖ ', -- when the hint is on the line below the current line
        --     },
        --     wrap = false,
        --     hi_parameter = 'LspSignatureActiveParameter',
        -- }
        -- require('lsp_signature').setup(sig_opts)

        -- Configure Neovim diagnostic messages
        local function prefix_diagnostic(prefix, diagnostic)
            return string.format(prefix .. ' %s', diagnostic.message)
        end

        vim.diagnostic.config {
            virtual_text = {
                prefix = '',
                format = function(diagnostic)
                    local severity = diagnostic.severity
                    if severity == vim.diagnostic.severity.ERROR then
                        return prefix_diagnostic('󰅚', diagnostic)
                    end
                    if severity == vim.diagnostic.severity.WARN then
                        return prefix_diagnostic('⚠', diagnostic)
                    end
                    if severity == vim.diagnostic.severity.INFO then
                        return prefix_diagnostic('ⓘ', diagnostic)
                    end
                    if severity == vim.diagnostic.severity.HINT then
                        return prefix_diagnostic('󰌶', diagnostic)
                    end
                    return prefix_diagnostic('■', diagnostic)
                end,
            },
            signs = {
                text = {
                    -- Requires Nerd fonts
                    [vim.diagnostic.severity.ERROR] = '󰅚',
                    [vim.diagnostic.severity.WARN] = '⚠',
                    [vim.diagnostic.severity.INFO] = 'ⓘ',
                    [vim.diagnostic.severity.HINT] = '󰌶',
                },
            },
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = 'minimal',
                border = 'single',
                source = 'if_many',
                header = '',
                prefix = '',
            },
        }
        require('lspconfig.ui.windows').default_options.border = 'single'
    end,
