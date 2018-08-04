local maid64 = require "lib.maid64"

local Player = require "src.Player"
local Map = require "src.Map"
local camera = require "src.camera"

function love.load()
	maid64.setup(64) -- Scale to 64 pixels squared

	gameObjects = {}
	playerObj = Player()
	table.insert(gameObjects, playerObj)

	maps = {}
	testmap = Map("res/testmap.lua")
	table.insert(maps, testmap)
	currentMap = testmap

	-- Using maid64 instead of love ensures that
	-- nearest neighbor scaling is used
	background = maid64.newImage("res/background.jpg")
end

function love.update(deltaTime)
	currentMap:update(deltaTime)
	for key, gameObject in pairs(gameObjects) do
		gameObject:update(deltaTime)
		currentMap:collide(gameObject)
	end
	-- Follow player always
	camera:setPosition(playerObj.x, playerObj.y)
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
			for key, gameObject in pairs(gameObjects) do
				gameObject:draw(true)
			end
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
