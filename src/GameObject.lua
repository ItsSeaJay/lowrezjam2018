local class = require "lib.classic"
local anim8 = require "lib.anim8"

local GameObject = class:extend()

function GameObject:new()
	self.destroyed = false
end

function GameObject:update(deltaTime)
	self.animation:update(deltaTime)
end

function GameObject:draw()
	if self.animation ~= nil then
		self.animation:draw(
			self.spritesheet,
			self.x - (self.cel.width / 2),
			self.y - (self.cel.height / 2)
		)
	end

	-- TODO: add support for static graphics
end

function GameObject:setWorld(right, bottom)
	self.worldRight = right
	self.worldBottom = bottom
end

return GameObject
