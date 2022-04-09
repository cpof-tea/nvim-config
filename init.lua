vim.opt.relativenumber = true
vim.opt.listchars = { tab = '→ ', space = '•', eol = '↵' }
vim.opt.signcolumn = 'yes'

vim.cmd([[
	highlight Comment cterm=none ctermfg=2
	highlight Statement cterm=bold ctermfg=5
	highlight Identifier cterm=none ctermfg=none
	highlight Function cterm=none ctermfg=3
	highlight Boolean cterm=none ctermfg=4
	highlight Number cterm=none ctermfg=4
	highlight String cterm=none ctermfg=1
]])

require('plugins')

syntaxStack = require('syntaxStack')
vim.api.nvim_set_keymap('n', 'gm', '<cmd>lua syntaxStack()<CR>', {})

