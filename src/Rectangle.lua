local class = require "lib.classic"
local Rectangle = class:extend()

function Rectangle:new(width, height)
	self.width = width
	self.height = height
end

return Rectangle
