local Map = require "src.Map"

-- Create a table for all of the maps in the game and return it
local maps = {}
maps.untitled = Map("src/maps/untitled.lua")
maps.mainHall = Map("src/maps/mainHall.lua")
maps.servantsCorridor = Map("src/maps/servantsCorridor.lua")

return maps
