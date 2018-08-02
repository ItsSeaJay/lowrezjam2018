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
	-- Draw a high-resolution background to fill in the black bars
	love.graphics.draw(background)

	-- NOTE: Everything between maid.start() and maid.finish() is downscaled
	-- NOTE: If a camera is used, it must be scaled seperately to 64 squared
	maid64.start()
		-- Default to a black background
		love.graphics.clear(0, 0, 0)
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

function love.resize(width, height)
    -- Alert maid64 that the width and height of the display changed so that
    -- it can fill it properly
    maid64.resize(width, height)
end
