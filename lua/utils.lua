local utils = {}

function utils.forEach(table, fn)
	for index, value in ipairs(table) do
		fn(value, index, table)
	end
end

function utils.merge(table1, table2)
	local newTable = {}

	for key, value in pairs(table1) do newTable[key] = value end
	for key, value in pairs(table2) do newTable[key] = value end

	return newTable
end

return utils
