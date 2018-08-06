local lume = require "lib.lume"
local maid64 = require "lib.maid64"
local class = require "lib.classic"

local Light = require "src.Light"
local LightingSystem = class:extend()

function LightingSystem:new(lights, shadowColour, alpha)
	self.lights = lights or {}
	-- Set the colour of no light using lume
	self.shadowColour = shadowColour or "#000000"
	self.alpha = alpha or 1
	self.canvas = love.graphics.newCanvas()

	love.graphics.setCanvas(self.mask)
		love.graphics.clear(lume.color(self.shadowColour))
	love.graphics.setCanvas()
end

function LightingSystem:add(light)
	table.insert(self.lights)
end

function LightingSystem:update(deltaTime)
	love.graphics.setCanvas(self.canvas)
		love.graphics.clear(lume.color(self.shadowColour, self.alpha))
		love.graphics.setBlendMode("multiply", "premultiplied")
		
		for key, light in pairs(self.lights) do
			love.graphics.draw(
				light.mask,
				light.x,
				light.y,
				0,
				1,
				1,
				light.mask:getWidth() / 2,
				light.mask:getHeight() / 2
			)
		end

		love.graphics.setBlendMode("alpha")
	love.graphics.setCanvas()
end

function LightingSystem:draw()
	love.graphics.setColor(lume.color("#FFFFFF"))
	love.graphics.draw(self.canvas)
end

return LightingSystem
