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

	-- Set the default scaling filter to nearest-neighbour
	love.graphics.setDefaultFilter("nearest", "nearest")

	-- Configure the starting map
	currentMap = {}
	setMap("untitled")

	-- Create canvases for the main game and lighting
	canvases = {}
	canvases.main = love.graphics.newCanvas(64, 64)
	canvases.lighting = love.graphics.newCanvas(64, 64)
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
	-- very important!: reset color before drawing to canvas to have colors properly displayed
    -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
    -- (Taken from the love2d wiki: https://love2d.org/wiki/Canvas)
	love.graphics.setColor(1, 1, 1, 1)

	love.graphics.draw(canvases.main)
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
