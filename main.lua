local gamera = require "lib.gamera"
local maid64 = require "lib.maid64"

local Player = require "src.Player"

function love.load()
	maid64.setup(64) -- Scale to 64 pixels squared

	player = Player()
	camera = gamera.new(0, 0, 128, 128)
	camera:setWindow(0, 0, 64, 64)

	-- Using maid64 instead of love ensures that
	-- nearest neighbor scaling is used
	background = maid64.newImage("res/background.jpg")
end

function love.update(deltaTime)
	player:update(deltaTime)
	camera:setPosition(player.x, player.y)
end

function love.draw(deltaTime)
	-- NOTE: Everything between maid.start() and maid.finish() is downscaled
	-- NOTE: If a camera is used, it must be scaled seperately to 64 squared
	maid64.start()
		camera:draw(function (left, top, width, height)
			-- Default to a black background
			love.graphics.clear(0, 0, 0)
			-- Draw a simple background to show movement from the camera
			love.graphics.draw(background)
			-- TODO: make this draw a table of in-tact game objects agnostically
			player:draw()
		end)
	maid64.finish()
end

function love.keypressed(key, scancode, isRepeat)
	-- TODO: remove this before the game ships, or replace it
	if key == "escape" then
		love.event.quit()
	end
end

function love.resize(width, height)
    -- Alert maid64 that the width and height of the display changed so that
    -- it can fill it properly
    maid64.resize(width, height)
end
