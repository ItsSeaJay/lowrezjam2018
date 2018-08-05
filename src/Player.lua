local class = require "lib.classic"
local maid64 = require "lib.maid64"
local anim8 = require "lib.anim8"
local helper = require "src.helper"
local directions = require "src.cardinalDirections"

local GameObject = require "src.GameObject"
local Rectangle = require "src.Rectangle"
local Player = GameObject:extend()

-- NOTE: This needs to be consistant across all animations
local celWidth = 16
local celHeight = celWidth

function Player:new()	
	-- Create a table for all of the animations that the player will use
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
			path = "res/player/idle/up.png",
			duration = 2
		},
		idleRight = {
			path = "res/player/idle/down.png",
			duration = 2
		}
	},
	celWidth,
	celHeight)

	-- Create a finite state machine of first class functions
	self.states = {}
	self.states.normal = function (deltaTime)
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

	self.state = self.states.normal
	self.animation = self.animations.idleDown
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

	self.state(deltaTime)
end

function Player:draw()
	self.super.draw(self)
end

return Player
