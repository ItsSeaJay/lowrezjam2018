local lume = require "lib.lume"
local class = require "lib.classic"
local erogodic = require "lib.erogodic"() -- This one returns a function

local fonts = require "src.fonts"
local script = require "src.messages.test"

local MessageBox = class:extend()

function MessageBox:new()
	self.script = erogodic(script)

	local node = self.script:next()

	self.characterLimit = 17 -- This looks like a magic number, but under the
	                         -- default font, 16 / 4 = 16 characters max.

	-- Create variables for the messages and how they should appear
	self.message = {}
	self.message.target = lume.wordwrap(
		node.msg,
		self.characterLimit
	)
	self.message.current = ""
	self.message.delta = 0
	self.message.speed = 16
	
	-- Create seperate Love2D text objects so that the text displays properly
	self.text = love.graphics.newText(
		fonts.tomThumbNew,
		self.message.current
	)
	self.margin = 2
	self.visible = true
end

function MessageBox:update(deltaTime)
	-- Scroll the text forward at a constant rate
	self.message.delta = math.min(
		self.message.delta + self.message.speed * deltaTime,
		string.len(self.message.target)
	)
	-- Set the current message to a substring of the target based on
	-- how far we are through the message
	self.message.current = string.sub(
		self.message.target,
		0,
		self.message.delta
	)
	-- Configure the text to use the current message at all times
	self.text:set(self.message.current)
end

function MessageBox:draw()
	if self.visible then
		love.graphics.draw(
			self.text,
			self.margin,
			64 - self.text:getHeight()
		)
	end
end

function MessageBox:advance()
    if self.script:hasNext() then
        if self.message.delta < string.len(self.message.target) then
        	-- Skip the scrolling and show the whole message
            self.message.delta = string.len(self.message.target)
        else
            local node = self.script:next()

            if node then
                self.message.target = lume.wordwrap(
			    	self.script:next().msg,
			    	self.characterLimit
			    )
                self.message.current = ""
                self.message.delta = 0
            else
                self.visible = false
            end
        end
    end
end

return MessageBox
