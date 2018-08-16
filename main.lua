local anim8 = require "lib.anim8"
local maid64 = require "lib.maid64"
local lume = require "lib.lume"

local Player = require "src.Player"
local MessageBox = require "src.MessageBox"
local Light = require "src.Light"
local LightingSystem = require "src.LightingSystem"

local player = Player(0, 0)
local fonts = require "src.fonts"
local maps = require "src.maps".init(player)
local camera = require "src.camera"


function setMap(name, connectionID)
	currentMap = maps[name]
	currentMap.nextMap = nil
	camera:setWorld(0, 0, currentMap:getDimensions())
	player:setWorld(currentMap:getDimensions())

	if connectionID then
		player:setPosition(currentMap:getDoorCenter(connectionID))

		for _, d in pairs(currentMap.doors) do
			d.zDown = true
		end
	else
		player:setPosition(currentMap:getSpawnPos())
	end
end

function love.load()
	-- Set the default scaling filter to nearest-neighbour
	love.graphics.setDefaultFilter("nearest", "nearest")

	maid64.setup(64) -- Scale the screen to 64 pixels squared

	state = "title"

	-- Configure the starting map
	currentMap = {}
	setMap("mainHall")

	-- Configure the game's lighting system
	lighting = LightingSystem(
		{},
		"#222034", -- Darkness colour
		0.80 -- Alpha
	)

	-- Test a message box
	messageBox = MessageBox()
end

function love.update(deltaTime)
	if state == "game" then
		if currentMap.nextMap then
			setMap(currentMap.nextMap, currentMap.connectedDoor)
		end

		currentMap:update(deltaTime)
		lighting:update(deltaTime)

		-- Follow the player always
		-- NOTE: We're probably going to want some kind of dynamic camera soon,
		--       but this will do for now
		camera:setPosition(player.x, player.y)
		messageBox:update(deltaTime)
	end
end

function love.draw(deltaTime)
	-- very important!: reset color before drawing to canvas to have colors properly displayed
    -- see discussion here: https://love2d.org/forums/viewtopic.php?f=4&p=211418#p211418
    -- (Taken from the love2d wiki: https://love2d.org/wiki/Canvas)
	love.graphics.setColor(lume.color("#FFFFFF"))

	-- NOTE: Everything between maid.start() and maid.finish() is downscaled 
	-- NOTE: If a camera is used, it must be scaled seperately to 64 squared 
	maid64.start()
		if state == "title" then
			local y = 4
			love.graphics.setFont(fonts.m3x6)
			love.graphics.print("Nobody's Home", 4, y)
			love.graphics.setFont(fonts.tomThumbNew)
			y = y + 12
			love.graphics.print("by Team Atlantis", 4, y)
			y = y + 8
			love.graphics.print("for LOWREZJAM", 4, y)
			y = y + 8
			love.graphics.print("Move with WASD", 4, y)
			y = y + 8
			love.graphics.print("Continue with\nSpace", 4, y)
		elseif state == "game" then
			-- Everything inside this function is drawn relative to the camera
			camera:draw(function (left, top, width, height)
				-- STI needs offsets passed to it directly
				currentMap:draw(-left, -top)
				lighting:draw()
			end)

			-- Anything that needs to be scaled, but sit on top of the camera's view
			-- should go down here
			messageBox:draw()
		end
	maid64.finish()
end

function love.keypressed(key, scancode, isRepeat)
	-- TODO: remove this before the game ships, or replace it so keys can
	--       be rebound
	if key == "escape" then
		love.event.quit()
	end

	if key == "space" then
		if state == "title" then 
			state = "game"
		end
		messageBox:advance()
	end

	currentMap:keypressed(key, scancode, isRepeat)
end

function love.resize(width, height)
    -- Alert maid64 that the width and height of the display changed so that
    -- it can fill it properly
    maid64.resize(width, height)
end
