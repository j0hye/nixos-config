deps.add {
    source = "nvim-treesitter/nvim-treesitter",
}
deps.later(function()
    require("nvim-treesitter.configs").setup {
        auto_install = false,
        highlight = {
            enable = true,
        },
    }
end)
