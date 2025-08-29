-- plugins/telescope.lua:
return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		require("telescope").setup({})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find,
			{ desc = 'Telescope fuzzy find in current buffer' })
	end
}
