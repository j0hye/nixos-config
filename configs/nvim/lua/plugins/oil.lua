return {
	"oil",
	before = function()
		deps.add({
			source = "stevearc/oil.nvim"
		})
	end,
	keys = {
		{ '<leader>e', function() require('oil').toggle_float() end, desc = 'File Browser' }
	},
	after = function()
		require('mini.icons').setup()
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
	end
}
