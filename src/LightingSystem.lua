local lume = require "lib.lume"
local maid64 = require "lib.maid64"
local class = require "lib.classic"

local Light = require "src.Light"
local LightingSystem = class:extend()

function LightingSystem:new(lights, lightColour, shadowColour)
	self.lights = lights or {}
	self.canvas = love.graphics.newCanvas()

	love.graphics.setCanvas(self.mask)
		love.graphics.clear(0, 0, 0)
	love.graphics.setCanvas()
end

function LightingSystem:update(deltaTime)
	love.graphics.setCanvas(self.canvas)
		love.graphics.clear(0, 0, 0) -- White
		love.graphics.setBlendMode("multiply", "premultiplied")
		
		for key, light in ipairs(self.lights) do
			love.graphics.draw(
				light.mask,
				light.x,
				light.y,
				0,
				1,
				1,
				64 / 2,
				64 / 2
			)
		end

		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()
end

function LightingSystem:draw()
	love.graphics.setColor(255, 255, 255, 200)
	love.graphics.draw(self.canvas)
	love.graphics.setColor(255, 255, 255)
end

return LightingSystem
