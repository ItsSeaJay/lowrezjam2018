function love.load()

end

function love.update(deltaTime)

end

function love.draw(deltaTime)

end

function love.keypressed(key, scancode, isRepeat)
	if key == "escape" then
		love.event.quit()
	end
end
