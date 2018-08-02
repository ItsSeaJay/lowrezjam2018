local maid64 = require "lib.maid64"

local Player = require "src.Player"

function love.load()
	maid64.setup(64) -- Scale to 64 pixels squared

	player = Player()

	-- Using maid64 instead of love ensures that
	-- nearest neighbor scaling is used
	background = maid64.newImage("res/background.jpg")
end

function love.update(deltaTime)
	player:update()
end

function love.draw(deltaTime)
	maid64.start()
		love.graphics.draw(background)
		player:draw()
	maid64.finish()
end

function love.keypressed(key, scancode, isRepeat)
	-- TODO: remove this before the game ships, or replace it with a different
	--       system
	if key == "escape" then
		love.event.quit()
	end
end