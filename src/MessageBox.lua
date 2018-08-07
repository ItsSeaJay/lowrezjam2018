local class = require "lib.classic"
local erogodic = require "lib.erogodic"()
local fonts = require "src.fonts"

local MessageBox = class:extend()

function MessageBox:new()
	self.script = erogodic(function ()
		msg "Hello, World!"
	end)
	self.message = {}
	self.message.target = self.script:next().msg
	self.message.current = ""
	self.message.delta = 0
	self.message.speed = 8
end

function MessageBox:update(deltaTime)
	self.message.delta = self.message.delta + self.message.speed * deltaTime
	self.message.current = string.sub(self.message.target, 0, self.message.delta)
end

function MessageBox:draw()
	love.graphics.setFont(fonts.tomThumbNew)
	love.graphics.print(self.message.current)
end

return MessageBox
