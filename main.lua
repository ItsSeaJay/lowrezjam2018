local maid64 = require "lib.maid64"
local anim8 = require "lib.anim8"

local Map = require "src.Map"
local maps = require "src.maps"
local camera = require "src.camera"

function setMap(name)
	currentMap.nextMap = nil
	currentMap = maps[name]
	camera:setWorld(0, 0, currentMap:getDimensions())
	currentMap:getPlayer():setWorld(currentMap:getDimensions())
end

function love.load()
	maid64.setup(64) -- Scale the screen to 64 pixels squared

	-- Create some global variables for all of the maps in the game
	currentMap = {}
	setMap("testmap")
end

function love.update(deltaTime)
	if currentMap.nextMap then
		setMap(currentMap.nextMap)
	end
	currentMap:update(deltaTime)

	-- Follow player always
	-- NOTE: We're probably going to want some kind of dynamic camera soon,
	--       but this will do for now
	camera:setPosition(currentMap:getPlayer().x, currentMap:getPlayer().y)
end

function love.draw(deltaTime)
	-- NOTE: Everything between maid.start() and maid.finish() is downscaled
	-- NOTE: If a camera is used, it must be scaled seperately to 64 squared
	maid64.start()
		-- NOTE: User interfaces can be drawn here with absolute positions

		camera:draw(function (left, top, width, height)
			-- Default to a black background
			love.graphics.clear(0, 0, 0)
			currentMap:draw(-left, -top) -- STI needs offsets passed to it directly
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
