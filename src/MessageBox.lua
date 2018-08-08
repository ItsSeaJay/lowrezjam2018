local lume = require "lib.lume"
local maid64 = require "lib.maid64"
local class = require "lib.classic"
local erogodic = require "lib.erogodic"() -- This one returns a function

local fonts = require "src.fonts"
local script = require "src.messages.test"

local MessageBox = class:extend()
local Gradient = require "src.Gradient"

function MessageBox:new()
	self.script = erogodic(script)

	local node = self.script:next()

	self.characterLimit = 16 -- This looks like a magic number, but under the
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
	
	-- A separate text object is needed to calculate the height of the overall
	-- string
	self.text = love.graphics.newText(
		fonts.tomThumbNew,
		self.message.target
	)

	-- Then fill in the rest of the information about this class
	self.margin = 2
	self.indicator = love.graphics.newImage("res/messageIndicator.png")
	self.visible = false
	self.gradient = Gradient(
		0, -- x
		64, -- y
		64, -- width
		0 -- height
	)
	self.targetHeight = -(self.text:getHeight() + self.margin)
	self.alpha = 0
	self.fadeSpeed = 2
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
	self.text:set(self.message.target)

	-- Add some animation in there with linear interpolation
	self.gradient.height = lume.lerp(
		self.gradient.height,
		self.targetHeight,
		self.fadeSpeed * deltaTime
	)

	-- Fade out the box it isn't visible
	if not self.visible then
		self.targetHeight = 0
	end
end

function MessageBox:draw()
	-- Draw a gradient to add contrast to the text
	self.gradient:draw()

	if self.visible then
		-- Draw some scrolling text on the screen based on the current message
		love.graphics.setFont(fonts.tomThumbNew)
		love.graphics.print(
			self.message.current,
			self.margin,
			64 - self.text:getHeight() -- Measured from the bottom of the
			                           -- maid64 view
		)

		-- Draw the message indicator if the whole message is displayed
		if self.message.current == self.message.target then
			local offset = math.sin(love.timer.getTime() * 4)

			love.graphics.draw(
				self.indicator,
				64 - self.indicator:getWidth() - self.margin,
				64 - self.indicator:getHeight() - self.margin + offset
			)
		end
	end
end

function MessageBox:advance()
    if self.script:hasNext() then
        if self.message.delta < string.len(self.message.target) then
        	-- Skip the scrolling and show the whole message
            self.message.delta = string.len(self.message.target)
        else
            local node = self.script:next()

            -- If there's a node on the next line of the script
            if node then
            	-- Begin to show it to the player
                self.message.target = lume.wordwrap(
			    	node.msg,
			    	self.characterLimit
			    )
                self.message.current = ""
                self.message.delta = 0
            else
            	-- Dismiss the box
                self.visible = false
            end
        end
    end
end

return MessageBox
