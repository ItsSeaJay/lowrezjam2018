local maid64 = require "lib.maid64"

local class = require "lib.classic"
local Light = class:extend()

function Light:new(x, y, mask)
	self.x = x or 0
	self.y = y or 0
	self.mask = mask or maid64.newImage("res/placeholders/light64.png")
end

return Light
