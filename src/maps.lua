local Map = require "src.Map"

-- Create a table for all of the maps in the game and return it
local mapsInitialiser = {}

-- Obtain all of the maps from the maps folder
function mapsInitialiser.init(player)
	local maps = {}
	local files = love.filesystem.getDirectoryItems("src/maps")

	for key, file in ipairs(files) do
		local path = "src/maps/" .. file
		local map = Map(path, player)
		local name = file:gsub(".lua", "")
		
		maps[name] = map
	end

	return maps
end

return mapsInitialiser
