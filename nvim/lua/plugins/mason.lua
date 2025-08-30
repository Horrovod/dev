return {

	{
		"mason-org/mason.nvim",
		config = function()
			require('mason').setup()
		end
	},

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require('mason-lspconfig').setup(
				{
					ensure_installed = { 'lua_ls', 'clangd' }
				}
			)
		end
	}
}
