local maid64 = require "lib.maid64"

local class = require "lib.classic"
local Light = class:extend()

function Light:new(mask)
	self.mask = maid64.newImage(mask)
end

return Light
