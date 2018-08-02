local Player = require "src.Player"

function love.load()
	player = Player()
end

function love.update(deltaTime)
	player:update()
end

function love.draw(deltaTime)
	player:draw()
end

function love.keypressed(key, scancode, isRepeat)
	if key == "escape" then
		love.event.quit()
	end
end
