local class = require "lib.classic"
local GameObject = class:extend()

function GameObject:new()
	self.destroyed = false
end

function GameObject:update(deltaTime) end

function GameObject:draw()
	love.graphics.draw(
		self.image,
		self.x,
		self.y
	)
end

return GameObject
