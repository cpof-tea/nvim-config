local utils = require('utils')

local function syntaxStack()
	local line = vim.fn.line('.')
	local col = vim.fn.col('.')

	utils.forEach(vim.fn.synstack(line, col), function(syntaxId) 
		local highlightId = vim.fn.synIDtrans(syntaxId)
		local syntaxGroup = vim.fn.synIDattr(syntaxId, 'name')
		local highlightGroup = vim.fn.synIDattr(highlightId, 'name')
		print(syntaxGroup, '->', highlightGroup)
	end)
end

return syntaxStack
