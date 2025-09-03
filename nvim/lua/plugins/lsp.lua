return {
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lsp-signature-help', -- Для постоянных подсказок сигнатур
		},
		config = function()
			-- Настройка nvim-cmp
			local cmp = require('cmp')
			cmp.setup {
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lsp_signature_help', priority = 1000 }, -- Подсказки сигнатур
				}),
				mapping = {
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
				},
				experimental = {
					ghost_text = true, -- Показывать "призрачный" текст автодополнения
				},
			}

			local lspconfig = require('lspconfig')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Общие настройки для всех LSP
			local on_attach = function(client, bufnr)
				-- Маппинги для быстрых переходов
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Перейти к определению
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- Перейти к реализации
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- Найти ссылки
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- Перейти к объявлению
				vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts) -- Показать подсказку
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- Переименовать
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- Предыдущая диагностика
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- Следующая диагностика
				vim.keymap.set('n', '<leader>b', '<C-o>', opts)      -- Вернуться назад

				-- Форматирование при сохранении
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end

			-- Настройка lua_ls
			lspconfig.lua_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
					},
				},
			}

			-- Настройка clangd с поддержкой compile_commands.json
			lspconfig.clangd.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index", -- Индексация в фоновом режиме
					"--header-insertion=iwyu", -- Авто-добавление include
					"--completion-style=detailed", -- Подробные автодополнения
					"--compile-commands-dir=.",
					"--fallback-style=webkit",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },                -- Поддерживаемые типы файлов
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"), -- Где искать compile_commands.json
			}
		end,
	},
}
