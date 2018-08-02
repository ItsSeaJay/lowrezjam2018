local class = require "lib.classic"
local maid64 = require "lib.maid64"

local GameObject = require "src.GameObject"
local Player = GameObject:extend()

function Player:new()
	self.image = maid64.newImage("res/alien.png")
	self.x = 0
	self.y = 0
	self.speed = 32
end

function Player:update(deltaTime)
	local up = love.keyboard.isDown("w")
	local down = love.keyboard.isDown("s")
	local left = love.keyboard.isDown("a")
	local right = love.keyboard.isDown("d")

	if up then
		self.y = self.y - self.speed * deltaTime
	elseif down then
		self.y = self.y + self.speed * deltaTime
	end

	if left then
		self.x = self.x - self.speed * deltaTime
	elseif right then
		self.x = self.x + self.speed * deltaTime
	end

	-- Clamp the player's position
	self.x = math.max(self.x, 0)
	self.y = math.max(self.y, 0)
end

function Player:draw()
	love.graphics.draw(
		self.image,
		self.x,
		self.y
	)
end

return Player
