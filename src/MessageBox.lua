local class = require "lib.classic"
local erogodic = require "lib.erogodic"() -- This one returns a function

local fonts = require "src.fonts"
local message = require "src.messages.test"

local MessageBox = class:extend()

function MessageBox:new()
	self.script = erogodic(message)
	self.message = {}
	self.message.target = self.script:next().msg
	self.message.current = ""
	self.message.delta = 0
	self.message.speed = 8 -- Characters per second
	self.visible = true
end

function MessageBox:update(deltaTime)
	-- Scroll the text forward at a constant rate
	self.message.delta = math.min(
		self.message.delta + self.message.speed * deltaTime,
		string.len(self.message.target)
	)
	self.message.current = string.sub(self.message.target, 0, self.message.delta)
end

function MessageBox:draw()
	love.graphics.setFont(fonts.tomThumbNew)
	
	if self.visible then
		love.graphics.print(self.message.current)
	end
end

function MessageBox:advance()
	print("script", self.script)
	print("hasNext()", self.script:hasNext())

	if self.script:hasNext() then
		if self.message.delta < string.len(self.message.target) then
			self.message.delta = string.len(self.message.target)
		else
			self.message.target = self.script:next().msg
			self.message.current = ""
			self.message.delta = 0
		end
	end
end

return MessageBox
