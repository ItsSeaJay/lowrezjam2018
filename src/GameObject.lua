local class = require "lib.classic"
local anim8 = require "lib.anim8"

local GameObject = class:extend()

function GameObject:new()
	self.destroyed = false
end

function GameObject:update(deltaTime)
	self.animation:update(deltaTime)
end

function GameObject:draw(centred)
	if centred then
		self.animation:draw(
			self.spritesheet,
			self.x - self.halfWidth,
			self.y - self.halfHeight
		)
	else
		self.animation:draw(
			self.spritesheet,
			self.x,
			self.y
		)
	end
end

return GameObject
