local gamera = require "lib.gamera"
camera = gamera.new(0, 0, 512, 512)
camera:setWindow(0, 0, 64, 64)

return camera
