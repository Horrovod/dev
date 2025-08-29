return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require('bufferline').setup({
				options = {
					mode = "buffers",
					numbers = "none",
					color_icons = "none",
					indicator = {
						style = "none",
					},
					
				}
			})
		end
	}
}
