local class = require "lib.classic"
local maid64 = require "lib.maid64"
local helper = require "src.helper"

local GameObject = require "src.GameObject"
local Player = GameObject:extend()

function Player:new()
	self.image = maid64.newImage("res/alien.png")
	self.x = 0
	self.y = 0
	self.halfWidth = self.image:getWidth() / 2
	self.halfHeight = self.image:getHeight() / 2
	self.speed = 32
end

function Player:update(deltaTime)
	local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
	local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
	local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")

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
	self.x = helper.clamp(self.x, self.halfWidth, 512 - self.halfWidth)
	self.y = helper.clamp(self.y, self.halfHeight, 512 - self.halfHeight)
end

return Player
