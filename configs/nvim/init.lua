-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
deps = MiniDeps

-- Set options, colorscheme, keymaps and autos
require('options')
require('colorscheme')
require('keymaps')
require('autocommands')

-- Add oil as default file explorer
deps.add { source = "stevearc/oil.nvim" }
deps.now(function()
    require('oil').setup {
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
            natural_order = true,
        },
        float = {
            padding = 2,
            max_width = 90,
            max_height = 0,
        },
        win_options = {
            wrap = true,
            winblend = 0,
        },
        keymaps = {
            ['<C-c>'] = false,
            ['q'] = 'actions.close',
            ['<Esc>'] = 'actions.close',
        },
    }
    vim.keymap.set("n", "<leader>e", function() require("oil").toggle_float() end, { desc = "Toggle [e]xplorer" })
end)

-- Enable mini plugins
require('mini.pairs').setup()
require('mini.align').setup()
require('mini.basics').setup()
require('mini.jump').setup()
require('mini.cursorword').setup()

-- Install lz.n and lazy load plugin dirs
deps.add { source = 'nvim-neorocks/lz.n' }
require('lz.n').load 'plugins'
require("lz.n").load("plugins.lang")
