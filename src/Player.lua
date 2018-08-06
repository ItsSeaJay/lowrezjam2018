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
	self.cel = Rectangle(celWidth, celHeight)
	self.animations = anim8.getAnimations({
		-- Idling
		idleUp = {
			path = "res/player/idle/up.png",
			duration = 2
		},
		idleDown = {
			path = "res/player/idle/down.png",
			duration = 2
		},
		idleLeft = {
			path = "res/player/idle/left.png",
			duration = 2
		},
		idleRight = {
			path = "res/player/idle/right.png",
			duration = 2
		},
		-- Walking
		walkUp = {
			path = "res/player/walk/up.png",
			duration = 0.1
		},
		walkDown = {
			path = "res/player/walk/down.png",
			duration = 0.1
		},
		walkLeft = {
			path = "res/player/walk/left.png",
			duration = 0.1
		},
		walkRight = {
			path = "res/player/walk/right.png",
			duration = 0.1
		}
	},
	celWidth,
	celHeight)

	self.states = {}
	self.states.normal = function (deltaTime)
		local up = love.keyboard.isDown("w") or love.keyboard.isDown("up")
		local down = love.keyboard.isDown("s") or love.keyboard.isDown("down")
		local left = love.keyboard.isDown("a") or love.keyboard.isDown("left")
		local right = love.keyboard.isDown("d") or love.keyboard.isDown("right")
		local horizontal = 0
		local vertical = 0
		local moving = up or down or left or right

		-- Movement
		-- Horizontal
		if left then
			horizontal = -1
		elseif right then
			horizontal = 1
		else
			horizontal = 0
		end

		-- Vertical
		if up then
			vertical = -1
		elseif down then
			vertical = 1
		else
			vertical = 0
		end

		if not moving then
			self.animation = self.animations.idleDown
		end

		-- Move within the boundaries of the current world
		self.x = self.x + self.speed * horizontal * deltaTime
		self.y = self.y + self.speed * vertical * deltaTime
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

function Player:draw()
	self.super.draw(self)
end

return Player
