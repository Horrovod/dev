vim.g.mapleader = " "

vim.keymap.set('i', 'jj','<ESC>')
vim.keymap.set('n', '<leader>w',':w<CR>')

vim.keymap.set('n', '<c-K>',':wincmd k <CR>')
vim.keymap.set('n', '<c-J>',':wincmd j <CR>')
vim.keymap.set('n', '<c-H>',':wincmd h <CR>')
vim.keymap.set('n', '<c-L>',':wincmd l <CR>')

vim.keymap.set('n', '<|>',':vsplit <CR>')
vim.keymap.set('n', '<\\>',':split <CR>')
vim.keymap.set('n', '<leader>e',':Neotree left toggle reveal <CR>')



vim.keymap.set('n', '<Tab>',':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<s-Tab>',':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>x',':BufferLinePickClose<CR>')
vim.keymap.set('n', '<c-x>',':BufferLineCloseOthers<CR>')
