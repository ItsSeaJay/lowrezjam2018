local anim8 = require "lib.anim8"
local maid64 = require "lib.maid64"
local lume = require "lib.lume"

local Map = require "src.Map"
local Light = require "src.Light"
local LightingSystem = require "src.LightingSystem"

local maps = require "src.maps"
local camera = require "src.camera"

function setMap(name)
	currentMap.nextMap = nil
	currentMap = maps[name]
	camera:setWorld(0, 0, currentMap:getDimensions())
	currentMap:getPlayer():setWorld(currentMap:getDimensions())
end

function love.load()
	-- Set the default scaling filter to nearest-neighbour
	love.graphics.setDefaultFilter("nearest", "nearest")

	maid64.setup(64) -- Scale the screen to 64 pixels squared

	-- Configure the starting map
	currentMap = {}
	setMap("untitled")

	-- Configure the game's lighting system
	lighting = LightingSystem(
		{ -- Lights list
			Light(32, 32)
		},
		"#222034", -- Darkness colour
		0.80 -- Alpha
	)

	-- Create a list of global fonts to use later
	fonts = {}
	fonts.tiny = love.graphics.newFont("res/fonts/tiny/tiny.ttf", 6)
	fonts.m3x6 = love.graphics.newFont("res/fonts/m3x6/m3x6.ttf", 16)
	fonts.xeniatype2 = love.graphics.newImageFont(
		"res/fonts/xeniatype2/xeniatype2.png",
		"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890" ..
		".,!?':;-+=&#@|"
	)
end

function love.update(deltaTime)
	if currentMap.nextMap then
		setMap(currentMap.nextMap)
	end

	currentMap:update(deltaTime)
	lighting:update(deltaTime)

	-- Follow the player always
	-- NOTE: We're probably going to want some kind of dynamic camera soon,
	--       but this will do for now
	camera:setPosition(currentMap:getPlayer().x, currentMap:getPlayer().y)
end

function love.draw(deltaTime)
	-- very important!: reset color before drawing to canvas to have colors properly displayed
    -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
    -- (Taken from the love2d wiki: https://love2d.org/wiki/Canvas)
	love.graphics.setColor(lume.color("#FFFFFF"))

	-- NOTE: Everything between maid.start() and maid.finish() is downscaled 
	-- NOTE: If a camera is used, it must be scaled seperately to 64 squared 
	maid64.start()
		-- Everything inside this function is drawn relative to the camera
		camera:draw(function (left, top, width, height)
			-- STI needs offsets passed to it directly
			currentMap:draw(-left, -top)
			lighting:draw()
		end)

		-- Anything that needs to be scaled, but sit on top of the camera's view
		-- should go down here
		love.graphics.setFont(fonts.xeniatype2)
		love.graphics.print("Hello, World!", 2, 2)
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
