vim.opt.relativenumber = true
vim.opt.listchars = { tab = '→ ', space = '•', eol = '↵' }
vim.opt.signcolumn = 'yes'

require('plugins')

syntaxStack = require('syntaxStack')
vim.api.nvim_set_keymap('n', 'gm', '<cmd>lua syntaxStack()<CR>', {})

