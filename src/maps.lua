local Map = require "src.Map"

-- Create a table for all of the maps in the game and return it
local maps = {}
maps.untitled = Map("src/maps/untitled.lua")

return maps
