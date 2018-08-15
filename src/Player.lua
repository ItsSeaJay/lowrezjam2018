local class = require "lib.classic"
local maid64 = require "lib.maid64"
local anim8 = require "lib.anim8"
local lume = require "lib.lume"

local GameObject = require "src.GameObject"
local Rectangle = require "src.Rectangle"
local Player = GameObject:extend()

-- NOTE: This needs to be consistant across all animations
local celWidth = 16
local celHeight = celWidth

function Player:new(x, y)
	self.health = 4
	self.cel = Rectangle(celWidth, celHeight)
	self.animations = anim8.getAnimations({
		-- Idling
		idleUp = {
			path = "res/animations/player/idle/up.png",
			duration = 2
		},
		idleDown = {
			path = "res/animations/player/idle/down.png",
			duration = 2
		},
		idleLeft = {
			path = "res/animations/player/idle/left.png",
			duration = 2
		},
		idleRight = {
			path = "res/animations/player/idle/right.png",
			duration = 2
		},
		-- Walking
		walkUp = {
			path = "res/animations/player/walk/up.png",
			duration = 0.1
		},
		walkDown = {
			path = "res/animations/player/walk/down.png",
			duration = 0.1
		},
		walkLeft = {
			path = "res/animations/player/walk/left.png",
			duration = 0.1
		},
		walkRight = {
			path = "res/animations/player/walk/right.png",
			duration = 0.1
		}
	},
	celWidth,
	celHeight)

	self.direction = "down"
	self.states = {}
	self.states.normal = function (deltaTime)
		local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
		local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
		local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
		local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")
		local moving = up or down or left or right

		self.speed = 32

		self:move(up, down, left, right)
		self:animate(moving)		

		-- Allow the player to ready their weapon with shift
		-- TODO: tie this to the 'gun' item in the player's inventory
		if love.keyboard.isDown("lshift") then
			self.state = self.states.strafing
		end
	end
	self.states.strafing = function(deltaTime)
		local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
		local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
		local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
		local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")
		local moving = up or down or left or right
		local strafing = love.keyboard.isDown("lshift")

		self.speed = 16

		-- Return to normal when the button is release
		if not strafing then
			self.state = self.states.normal
		end

		self:move(up, down, left, right, true)
		self:animate(moving)
	end
	self.states.reading = function(deltaTime)
		-- Wait for the current message box script to end
	end

	self.state = self.states.normal
	self.animation = self.animations.idleDown
	self.x = x or 0
	self.y = y or 0
	self.boundingBox = Rectangle(6, 12)
	self.speed = 32
	self.worldRight = 512
	self.worldBottom = 512
end

function Player:update(deltaTime)
	-- Call the superclass
	self.super.update(self, deltaTime)

	self.state(deltaTime)
end

function Player:move(up, down, left, right, strafing)
	local horizontal, vertical
	local changeDirection = false or (not strafing)

	-- Horizontal
	if left then
		horizontal = -1

		if changeDirection then
			self.direction = "left"
		end
	elseif right then
		horizontal = 1
		
		if changeDirection then
			self.direction = "right"
		end
	else
		horizontal = 0
	end

	-- Vertical
	if up then
		vertical = -1
		
		if changeDirection then
			self.direction = "up"
		end
	elseif down then
		vertical = 1

		if changeDirection then
			self.direction = "down"
		end
	else
		vertical = 0
	end

	-- Move within the boundaries of the current world
	self.x = self.x + self.speed * horizontal * love.timer.getDelta()
	self.y = self.y + self.speed * vertical * love.timer.getDelta()
	self.x = lume.clamp(
		self.x,
		(self.boundingBox.width / 2),
		self.worldRight - (self.boundingBox.width / 2)
	)
	self.y = lume.clamp(
		self.y,
		(self.boundingBox.height / 2),
		self.worldBottom - (self.boundingBox.height / 2)
	)
end

function Player:animate(moving)
	if moving then
		if self.direction == "up" then
			self.animation = self.animations.walkUp
		elseif self.direction == "down" then
			self.animation = self.animations.walkDown
		elseif self.direction == "left" then
			self.animation = self.animations.walkLeft
		elseif self.direction == "right" then
			self.animation = self.animations.walkRight
		end
	else
		if self.direction == "up" then
			self.animation = self.animations.idleUp
		elseif self.direction == "down" then
			self.animation = self.animations.idleDown
		elseif self.direction == "left" then
			self.animation = self.animations.idleLeft
		elseif self.direction == "right" then
			self.animation = self.animations.idleRight
		end
	end
end

function Player:draw()
	self.super.draw(self)
end

return Player
