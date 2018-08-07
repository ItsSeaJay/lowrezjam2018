local fonts = {}
fonts.tiny = love.graphics.newFont("res/fonts/tiny/tiny.ttf", 6)
fonts.m3x6 = love.graphics.newFont("res/fonts/m3x6/m3x6.ttf", 16)
fonts.xeniatype2 = love.graphics.newImageFont(
	"res/fonts/xeniatype2/xeniatype2.png", -- File path
	-- Glyphs
	" " .. 
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" ..
	"abcdefghijklmnopqrstuvwxyz" .. 
	"1234567890" ..
	".,!?':;-+=&#@|"
)
fonts.tomThumbNew = love.graphics.newImageFont(
	"res/fonts/tomThumbNew/tomThumbNewASCIISpritefont.png",
	" !\"#$%'()*+,-./" ..
	"0123456789" ..
	":;<=>?@" ..
	"ABCDEFGHIJKLMNOPQRSTUVWXYZ" ..
	"[\\]^_" ..
	"abcdefghijklmnopqrstuvwxyz" ..
	"{|}~`"
)

return fonts
