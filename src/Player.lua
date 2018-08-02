local class = require "lib.classic"
local Player = class:extend()

function Player:new()
	self.image = love.graphics.newImage("res/alien.png")
end

function Player:update(deltaTime)

end

function Player:draw()
	love.graphics.draw(self.image)
end

return Player
