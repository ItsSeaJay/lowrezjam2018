local maid64 = require "lib.maid64"
local anim8 = require "lib.anim8"

local Map = require "src.Map"
local camera = require "src.camera"

function setmap(name)
	currentMap = maps[name]
	camera:setWorld(0, 0, currentMap:getWidth(), currentMap:getHeight())
	currentMap:getPlayer():setWorld(currentMap:getWidth(), currentMap:getHeight())
end

function love.load()
	maid64.setup(64) -- Scale to 64 pixels squared

	maps = {}
	maps["testmap"] = Map("res/testmap.lua")
	setmap("testmap")

	-- TODO: Remove this test animation from the game
	coin = love.graphics.newImage('res/coin.png')
	local g = anim8.newGrid(8, 8, coin:getWidth(), coin:getHeight())
	animation = anim8.newAnimation(g('1-2', 1), 0.1)

	-- Using maid64 instead of love ensures that
	-- nearest neighbor scaling is used
	background = maid64.newImage("res/background.jpg")
end

function love.update(deltaTime)
	currentMap:update(deltaTime)

	animation:update(deltaTime)

	-- Follow player always
	-- NOTE: We're probably going to want some kind of dynamic camera soon,
	--       but this will do for now
	camera:setPosition(currentMap:getPlayer().x, currentMap:getPlayer().y)
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
			currentMap:draw(-left, -top) -- STI needs offsets passed to it directly
		end)
	maid64.finish()

	animation:draw(coin, 100, 200)
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
