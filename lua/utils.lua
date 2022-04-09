local utils = {}

function utils.forEach(table, fn)
	for index, value in ipairs(table) do
		fn(value, index, table)
	end
end

return utils
