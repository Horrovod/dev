vim.g.mapleader = " "

vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<Esc>', ':noh<CR>')

vim.keymap.set('n', '<c-C>', 's-v')

vim.keymap.set('n', '<c-K>', ':wincmd k <CR>')
vim.keymap.set('n', '<c-J>', ':wincmd j <CR>')
vim.keymap.set('n', '<c-H>', ':wincmd h <CR>')
vim.keymap.set('n', '<c-L>', ':wincmd l <CR>')

vim.keymap.set('i', '<c-L>', '<right>')
vim.keymap.set('i', '<c-K>', '<up>')
vim.keymap.set('i', '<c-J>', '<down>')
vim.keymap.set('i', '<c-H>', '<left>')

vim.keymap.set('n', '|', ':vsplit <CR>')
vim.keymap.set('n', '\\', ':split <CR>')
vim.keymap.set('n', '<leader>e', ':Neotree left toggle reveal <CR>')


-- Создаем группу автокоманды
local group = vim.api.nvim_create_augroup('ToggleTermKeymap', { clear = true })

-- Устанавливаем маппинг для BufferLine в нормальном режиме
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })

-- Отключаем <Tab> для toggleterm
vim.api.nvim_create_autocmd('TermOpen', {
	group = group,
	pattern = '*',
	callback = function()
		-- Отключаем <Tab> в нормальном режиме для терминала
		vim.keymap.set('n', '<Tab>', '<Nop>', { buffer = true, noremap = true, silent = true })
		-- Отключаем <Tab> в терминальном режиме
		vim.keymap.set('t', '<Tab>', '<Tab>', { buffer = true, noremap = true, silent = true })
	end,
})
vim.keymap.set('n', '<s-Tab>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>x', ':BufferLinePickClose<CR>')
vim.keymap.set('n', '<s-x>', ':BufferLineCloseOthers<CR>')
