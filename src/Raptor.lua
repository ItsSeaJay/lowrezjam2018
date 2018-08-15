local maid64 = require "lib.maid64"

local GameObject = require "src.GameObject"
local Raptor = GameObject:extend()
local Rectangle = require "src.Rectangle"

local celWidth = 16
local celHeight = 32

function Raptor:new(x, y)
	self.x = x
	self.y = y
	self.image = maid64.newImage("res/raptor.png")
	self.cel = Rectangle
	self.cel.width = self.image:getWidth()
	self.cel.height = self.image:getHeight()
	self.health = 3
end

return Raptor
