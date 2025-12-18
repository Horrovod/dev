return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help',
		},
		config = function()
			-- nvim-cmp
			local cmp = require('cmp')
			cmp.setup {
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help', priority = 1000 },
				}),
				mapping = {
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
				},
				experimental = {
					ghost_text = true,
				},
			}

			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Общий on_attach
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }

				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', '<leader>b', '<C-o>', opts)

				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end

			-- lua_ls (новый API)
			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { 'vim' } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			})

			-- clangd (новый API)
			vim.lsp.config("clangd", {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--compile-commands-dir=.",
					"--fallback-style=webkit",
				},
				filetypes = { "c", "cc", "hh", "h", "cpp", "objc", "objcpp" },
				root_dir = vim.fs.root(0, { "compile_commands.json", ".git" }),
			})
		end,
	},
}
