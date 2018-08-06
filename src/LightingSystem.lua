local maid64 = require "lib.maid64"
local class = require "lib.classic"

local Light = require "src.Light"
local LightingSystem = class:extend()

function LightingSystem:new(lights)
	self.lights = lights or {}
	self.canvas = love.graphics.newCanvas()
end

return LightingSystem
