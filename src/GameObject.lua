local class = require "lib.classic"
local anim8 = require "lib.anim8"

local GameObject = class:extend()

function GameObject:new()
	self.destroyed = false
	self.depth = 0
end

function GameObject:update(deltaTime)
	if self.animation then
		self.animation.motion:update(deltaTime)
	end
end

function GameObject:draw()
	if self.animation then
		self.animation.motion:draw(
			self.animation.spritesheet,
			self.x - (self.cel.width / 2),
			self.y - (self.cel.height / 2)
		)
	else
		love.graphics.draw(
			self.image,
			self.x - (self.cel.width / 2),
			self.y - (self.cel.width / 2)
		)
	end
end

function GameObject:setWorld(right, bottom)
	self.worldRight = right
	self.worldBottom = bottom
end

function GameObject:setPosition(x, y)
	self.x, self.y = x, y
end

return GameObject
