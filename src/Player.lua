local class = require "lib.classic"
local maid64 = require "lib.maid64"
local anim8 = require "lib.anim8"
local helper = require "src.helper"
local directions = require "src.cardinalDirections"

local GameObject = require "src.GameObject"
local Player = GameObject:extend()

function Player:new()
	-- Get a reference to the spritesheet image for the player
	self.spritesheet = maid64.newImage("res/player.png")
	
	-- Create a table for all of the animations that the player will use
	-- TODO: Make a function for this using loops
	self.animations = self:getAnimations()

	-- Set a default animation
	self.animation = self.animations.walkDown
	self.direction = directions.down
	self.x = 0
	self.y = 0
	self.halfWidth = 8
	self.halfHeight = 8
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

	-- Clamp the player's position
	self.x = helper.clamp(self.x, self.halfWidth, self.worldRight - self.halfWidth)
	self.y = helper.clamp(self.y, self.halfHeight, self.worldBottom - self.halfHeight)

	if self.direction == directions.up and moving then
		self.animation = self.animations.walkUp
	elseif self.direction == directions.down and moving then
		self.animation = self.animations.walkDown
	elseif self.direction == directions.left and moving then
		self.animation = self.animations.walkLeft
	elseif self.direction == directions.right and moving then
		self.animation = self.animations.walkRight
	end

	if moving then
		self.animation:resume()
	else
		self.animation:pause()
	end
end

function Player:getAnimations()
	local celWidth = 16
	local celHeight = celWidth
	-- Cut that spritesheet up into a grid
	local grid = anim8.newGrid(
		celWidth, -- Cel width
		celHeight, -- Cel height
		self.spritesheet:getWidth(), -- Spritesheet width
		self.spritesheet:getHeight() -- Spritesheet height
	)
	local animations = {}

	-- Walking
	animations.walkDown = anim8.newAnimation(
		grid(
			'1-8', -- Cels used
			1 -- Row
		),
		0.1 -- Duration per cel
	)
	animations.walkUp = anim8.newAnimation(
		grid(
			'1-8', -- Cels used
			4 -- Row
		),
		0.1 -- Duration per cel
	)
	animations.walkLeft = anim8.newAnimation(
		grid(
			'1-8', -- Cels used
			3 -- Row
		),
		0.1 -- Duration per cel
	)
	animations.walkRight = anim8.newAnimation(
		grid(
			'1-8', -- Cels used
			2 -- Row
		),
		0.1 -- Duration per cel
	)

	return animations
end

function Player:setWorld(right, bottom)
	self.worldRight = right
	self.worldBottom = bottom
end

return Player
