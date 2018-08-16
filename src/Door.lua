local GameObject = require "src.GameObject"
local Door = GameObject:extend()

local lockedScript = require "src.messages.locked"
local threshold = 10

function Door:new(x, y, width, height, map, nextMap, connectionID)
	self:setPosition(x, y)
	self.width = width
	self.height = height
	self.map = map
	self.nextMap = nextMap
	self.connectionID = connectionID
	self.nearby = false
end

-- Use playerInteraction on GameObjects for collision and such
function Door:interact(player)
	self.nearby = false

	if (math.abs(player.x - self.x) < threshold and
		math.abs(player.y - self.y) < threshold) then

		self.map.nextMap = self.nextMap
		self.map.connectedDoor = self.connectionID

		self.nearby = true
	end
end

return Door
