local GameObject = require "src.GameObject"

local Door = GameObject:extend()

function Door:new(x, y, map, nextMap, connectionID)
	self:setPosition(x, y)
	self.map = map
	self.nextMap = nextMap
	self.connectionID = connectionID
	self.nearby = false
end

local threshold = 20

-- Use playerInteraction on GameObjects for collision and such
function Door:playerInteraction(player)
	self.nearby = false
	if (math.abs(player.x - self.x) < threshold
	and math.abs(player.y - self.y) < threshold) then
		if love.keyboard.isDown("z") then
			self.map.nextMap = self.nextMap
			self.map.connectedDoor = self.connectionID
		end
		self.nearby = true
	end
end

--animations for opening/closing? might not be necessary but perhaps a fading to black

return Door
