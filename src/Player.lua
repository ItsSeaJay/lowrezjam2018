local class = require "lib.classic"
local maid64 = require "lib.maid64"

local Player = class:extend()

function Player:new()
	self.image = maid64.newImage("res/alien.png")
end

function Player:update(deltaTime)

end

function Player:draw()
	love.graphics.draw(self.image)
end

return Player
