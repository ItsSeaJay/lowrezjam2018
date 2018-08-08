local class = require "lib.classic"
local lume = require "lib.lume"

local Gradient = class:extend()

local rectangularMesh = love.graphics.newMesh({
	{0, 0, 0, 0, 1, 1, 1, 1},
	{1, 0, 1, 0, 1, 1, 1, 1},
	{0, 1, 0, 1, 0, 0, 0, 0},
	{1, 1, 1, 1, 0, 0, 0, 0}
}, "strip", "static")

function Gradient:new(x, y, width, height, colour)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.colour = colour or "#000000" -- Black
end

function Gradient:draw()
	love.graphics.setColor(lume.color(self.colour))
	love.graphics.draw(
		rectangularMesh,
		self.x,
		self.y,
		0,
		self.width,
		self.height
	)
	love.graphics.setColor(1, 1, 1)
end

return Gradient
