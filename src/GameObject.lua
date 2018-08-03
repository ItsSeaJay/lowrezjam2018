local class = require "lib.classic"
local GameObject = class:extend()

function GameObject:new()
	self.destroyed = false
end

function GameObject:update(deltaTime) end

function GameObject:draw(centred)
	if centred then
		love.graphics.draw(
			self.image,
			self.x - self.halfWidth,
			self.y - self.halfHeight
		)
	else
		love.graphics.draw(
			self.image,
			self.x,
			self.y
		)
	end
end

return GameObject
