return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lspconfig = require('lspconfig')

			-- Общие настройки для всех LSP
			local on_attach = function(client, bufnr)
				local capabilities = require('cmp_nvim_lsp').default_capabilities()

				-- Маппинги для быстрых переходов
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Перейти к определению
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts) -- Перейти к реализации
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- Найти ссылки
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- Перейти к объявлению
				vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts) -- Показать подсказку
				vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- Переименовать
				vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
				--        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) -- Показать диагностику
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
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
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
				capabilities = require('cmp_nvim_lsp').default_capabilities(),
				cmd = {
					"clangd",
					"--background-index",                                    -- Индексация в фоновом режиме
					"--compile-commands-dir=.",                              -- Путь к compile_commands.json (можно указать, например, "./build")
					"--fallback-style=webkit",
					"--clang-tidy",                                          -- Включить clang-tidy для дополнительных проверок
					"--completion-style=bundled",                            -- Стиль автодополнения
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },                -- Поддерживаемые типы файлов
				root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"), -- Где искать compile_commands.json
			}
		end,
	},
}
