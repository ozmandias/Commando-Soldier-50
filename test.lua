function mouse_test(mx, my)
    local sw, sh = gameWidth, gameHeight -- love.graphics.getDimensions()
    -- local mx, my = love.mouse.getPosition()
    love.graphics.setColor(0.3, 0.4, 0.5)
    love.graphics.setLineWidth(5)
    love.graphics.line(0, my, sw, my)
    love.graphics.line(mx, 0, mx, sh)
    love.graphics.circle("fill", mx, my, love.mouse.isDown(1) and 30 or 10)
end