-- Helper functions
local helper = {}

function helper.clamp(value, lower, upper)
	if value < lower then
		return lower
	end
	if value > upper then
		return upper
	end
	return value
end

return helper
