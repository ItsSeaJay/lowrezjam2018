local class = require "lib.classic"
-- Simple Tiled Implementation
local sti = require "lib.sti"
local Door = require "src.Door"

local Player = require "src.Player"
local Raptor = require "src.Raptor"
local Map = class:extend()

function Map:new(path, player)
	self.tilemap = sti(path)
	self.mainLayer = self.tilemap.layers[1]
	self.gameObjects = {}
	self.doors = {}
	self.playerObj = player
	self.spawn = {}

	-- Create objects based on those in the map
	for key, object in pairs(self.tilemap.objects) do
		-- move this elsewhere
		if object.name == "Player" then
			-- Put the player object at their spawn point
			self.playerObj:setPosition(object.x, object.y)
			self.spawn.x, self.spawn.y = object.x, object.y

			table.insert(self.gameObjects, self.playerObj)
		end
		if object.name == "Door" then
			local doorObj = Door(
				object.x,
				object.y,
				self,
				object.properties.nextMap,
				object.properties.connectionID
			)
			print("doro")
			table.insert(self.gameObjects, doorObj)
			self.doors[object.properties.connectionID] = doorObj
		end
	end

	-- Remove the unneeded layer
	self.tilemap:removeLayer("Objects")
end

function Map:update(dt)
    self.tilemap:update(dt)

	for _, gameObject in pairs(self.gameObjects) do
		gameObject:update(dt)
		if gameObject.playerInteraction then
			gameObject:playerInteraction(self.playerObj)
		end
		self:collide(gameObject)
	end
end

function Map:draw(tx, ty, sx, sy)
    self.tilemap:draw(tx, ty, sx, sy)

	for _, gameObject in pairs(self.gameObjects) do
		if gameObject.image or gameObject.animation then
			gameObject:draw(true)
		end
	end
end

function Map:safeGetTile(x, y)
	-- For some reason need to add 1. STI is kinda bugged in a few places like this
	if self.mainLayer.data[y + 1] then
		return self.mainLayer.data[y + 1][x + 1]
	end

	return nil
end

function Map:getDimensions()
	return self.tilemap.tilewidth * self.mainLayer.width,
	       self.tilemap.tileheight * self.mainLayer.height
end

function Map:getDoorCenter(connectionID)
	return self.doors[connectionID].x,
	       self.doors[connectionID].y
end

function Map:getSpawnPos()
	return self.spawn.x, self.spawn.y
end

function Map:collide(go)
	if not go.boundingBox then
		do return end
	end

	-- Stop the entity moving through tiles with the 'solid' property set to true
	local x, y, tile
	local n = math.floor(go.boundingBox.height / 2) - 1

	for i = -n, n, n do
		-- Right
		x, y = self.tilemap:convertPixelToTile(go.x + go.boundingBox.width / 2, go.y + i)
		tile = self:safeGetTile(x, y)

		if tile and tile.properties.solid then
			go.x = (x)*self.tilemap.tilewidth - go.boundingBox.width / 2
		end

		-- Left
		x, y = self.tilemap:convertPixelToTile(go.x - go.boundingBox.width / 2, go.y + i)
		tile = self:safeGetTile(x, y)

		if tile and tile.properties.solid then
			go.x = (x+1)*self.tilemap.tilewidth + go.boundingBox.width / 2
		end
	end

	n = math.floor(go.boundingBox.width / 2) - 1

	for i = -n, n, n do
		-- Up
		x, y = self.tilemap:convertPixelToTile(go.x + i, go.y - go.boundingBox.height / 2)
		tile = self:safeGetTile(x, y)

		if tile and tile.properties.solid then
			go.y = (y+1)*self.tilemap.tileheight + go.boundingBox.height / 2
		end

		-- Down
		x, y = self.tilemap:convertPixelToTile(go.x + i, go.y + go.boundingBox.height / 2)
		tile = self:safeGetTile(x, y)

		if tile and tile.properties.solid then
			go.y = (y) * self.tilemap.tileheight - go.boundingBox.height / 2
		end
	end
end

return Map
