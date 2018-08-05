local class = require "lib.classic"
local maid64 = require "lib.maid64"
local anim8 = require "lib.anim8"
local helper = require "src.helper"
local directions = require "src.cardinalDirections"

local GameObject = require "src.GameObject"
local Rectangle = require "src.Rectangle"
local Player = GameObject:extend()

local celWidth = 16
local celHeight = celWidth

function Player:new()	
	-- Create a table for all of the animations that the player will use
	-- TODO: Make a function for this using loops
	self.cel = Rectangle(celWidth, celHeight)
	self.animations = self:getAnimations()

	-- Set a default animation
	self.animation = self.animations.walkUp
	self.image = maid64.newImage("res/alien.png")

	self.direction = directions.down
	self.x = 0
	self.y = 0
	self.boundingBox = Rectangle(6, 12)
	self.speed = 32
	self.worldRight = 512
	self.worldBottom = 512
end

function Player:update(deltaTime)
	-- Call the superclass
	self.super.update(self, deltaTime)

	local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
	local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
	local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
	local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")
	local moving = up or down or left or right

	-- Movement
	-- Horizontal
	if up then
		self.y = self.y - self.speed * deltaTime
		self.direction = directions.up
	elseif down then
		self.y = self.y + self.speed * deltaTime
		self.direction = directions.down
	end

	-- Vertical
	if left then
		self.x = self.x - self.speed * deltaTime
		self.direction = directions.left
	elseif right then
		self.x = self.x + self.speed * deltaTime
		self.direction = directions.right
	end

	-- Clamp the player's position within the current world
	self.x = helper.clamp(
		self.x,
		(self.boundingBox.width / 2),
		self.worldRight - (self.boundingBox.width / 2)
	)
	self.y = helper.clamp(
		self.y,
		(self.boundingBox.height / 2),
		self.worldBottom - (self.boundingBox.height / 2)
	)
end

function Player:draw()
	self.super.draw(self)
end

function Player:getAnimations()
	local animations = {}
	local paths = {
		walkUp = "res/player/walk/up.png"
	}

	-- Create new animations for each spritesheet found
	for key, path in pairs(paths) do
		if love.filesystem.getInfo(path) then
			local spritesheet = love.graphics.newImage(path)
			local grid = anim8.newGrid(
				self.cel.width,
				self.cel.height,
				spritesheet:getWidth(),
				spritesheet:getHeight()
			)
			-- NOTE: The cel width must fit into the spritesheet exactly
			local range = '1-' .. (spritesheet:getWidth() / self.cel.width)
			local duration = 0.1
			local animation = anim8.newAnimation(
				grid:getFrames(
					range,
					1 -- Row
				),
				duration
			)

			-- Store the animation info in the table under the specified key
			animations[key] = {
				spritesheet = spritesheet,
				motion = animation
			}

			print(animations[key])
		else
			print("WARNING!", path, "does not exist!")
		end
	end

	return animations
end

return Player
