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

function Map:collide(go)
	-- Might update this later since it's kinda crappy on corners
	-- Right
	local x, y = self.stimap:convertPixelToTile(go.x + go.halfWidth, go.y)
	local tile = self:safeGetTile(x, y)
	if tile and tile.properties.physical then
		go.x = (x)*self.stimap.tilewidth - go.halfWidth
	end
	-- Left
	x, y = self.stimap:convertPixelToTile(go.x - go.halfWidth, go.y)
	tile = self:safeGetTile(x, y)
	if tile and tile.properties.physical then
		go.x = (x+1)*self.stimap.tilewidth + go.halfWidth
	end
	-- Up
	x, y = self.stimap:convertPixelToTile(go.x, go.y - go.halfHeight)
	tile = self:safeGetTile(x, y)
	if tile and tile.properties.physical then
		go.y = (y+1)*self.stimap.tileheight + go.halfHeight
	end
	-- Down
	x, y = self.stimap:convertPixelToTile(go.x, go.y + go.halfHeight)
	tile = self:safeGetTile(x, y)
	if tile and tile.properties.physical then
		go.y = (y)*self.stimap.tileheight - go.halfHeight
	end
end

return Map
