local class = "lib.classic"
local BoundingBox = class:extend()

function BoundingBox:new(width, height)
	self.width = width
	self.height = height
end

return BoundingBox
