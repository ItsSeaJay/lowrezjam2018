local class = require "lib.classic"
local sti = require "lib.sti"
local helper = require "src.helper"

local Map = class:extend()

function Map:new(mapLocation)
	self.stimap = sti(mapLocation)
	self.mainLayer = self.stimap.layers[1]
end

function Map:update(dt)
    self.stimap:update(dt)
end

function Map:draw(tx, ty, sx, sy)
    self.stimap:draw(tx, ty, sx, sy)
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
		x, y = self.stimap:convertPixelToTile(go.x + go.halfWidth, go.y + i)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.x = (x)*self.stimap.tilewidth - go.halfWidth
		end
		-- Left
		x, y = self.stimap:convertPixelToTile(go.x - go.halfWidth, go.y + i)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.x = (x+1)*self.stimap.tilewidth + go.halfWidth
		end
		-- Up
		x, y = self.stimap:convertPixelToTile(go.x + i, go.y - go.halfHeight)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.y = (y+1)*self.stimap.tileheight + go.halfHeight
		end
		-- Down
		x, y = self.stimap:convertPixelToTile(go.x + i, go.y + go.halfHeight)
		tile = self:safeGetTile(x, y)
		if tile and tile.properties.physical then
			go.y = (y)*self.stimap.tileheight - go.halfHeight
		end
	end
end

return Map
