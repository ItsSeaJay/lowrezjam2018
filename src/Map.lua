local class = require "lib.classic"
local sti = require "lib.sti"
local Player = require "src.Player"

local Map = class:extend()

function Map:new(mapLocation)
	self.stimap = sti(mapLocation)
	self.mainLayer = self.stimap.layers[1]
	self.gameObjects = {}
	self.playerObj = Player()
	table.insert(self.gameObjects, self.playerObj)
end

function Map:update(dt)
    self.stimap:update(dt)
    
	for _, gameObject in pairs(self.gameObjects) do
		gameObject:update(dt)
		self:collide(gameObject)
	end
end

function Map:draw(tx, ty, sx, sy)
    self.stimap:draw(tx, ty, sx, sy)

	for _, gameObject in pairs(self.gameObjects) do
		gameObject:draw(true)
	end
end

function Map:getPlayer()
	return self.playerObj
end

function Map:safeGetTile(x, y)
	-- For some reason need to add 1. STI is kinda bugged in a few places like this
	if self.mainLayer.data[y+1] then
		return self.mainLayer.data[y+1][x+1]
	end
	return nil
end

function Map:getWidth()
	return self.stimap.tilewidth * self.mainLayer.width
end

function Map:getHeight()
	return self.stimap.tileheight * self.mainLayer.height
end

function Map:collide(go)
	local x, y, tile

	for i = -5, 5, 5 do
		-- Right
		x, y = self.stimap:convertPixelToTile(go.x + go.boundingBox.width / 2, go.y + i)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.x = (x)*self.stimap.tilewidth - go.boundingBox.width / 2
		end
		-- Left
		x, y = self.stimap:convertPixelToTile(go.x - go.boundingBox.width / 2, go.y + i)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.x = (x+1)*self.stimap.tilewidth + go.boundingBox.width / 2
		end
		-- Up
		x, y = self.stimap:convertPixelToTile(go.x + i, go.y - go.boundingBox.height / 2)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.y = (y+1)*self.stimap.tileheight + go.boundingBox.height / 2
		end
		-- Down
		x, y = self.stimap:convertPixelToTile(go.x + i, go.y + go.boundingBox.height / 2)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.y = (y)*self.stimap.tileheight - go.boundingBox.height / 2
		end
	end
end

return Map
