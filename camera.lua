function camera_translate()
    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()
    mouseX, mouseY = push:toGame(mouseX, mouseY)
    
    if startgame == true then
        -- left
        if soldiercharacter.horizontal <= 300 then
            -- top
            if soldiercharacter.vertical <= 260 then
                love.graphics.translate(0,40)
                mouseY = mouseY - 40
            -- bottom
            elseif soldiercharacter.vertical >= 520 then
                love.graphics.translate(0,-220)
                mouseY = mouseY - (-220)
            else
                -- print("left else with horizontal: "..soldiercharacter.horizontal..", vertical: "..soldiercharacter.vertical)
                love.graphics.translate(0,-soldiercharacter.vertical+300)
                mouseY = mouseY - (-soldiercharacter.vertical+300)
            end
        -- right
        elseif soldiercharacter.horizontal >= 420 then
            -- top
            if soldiercharacter.vertical <=260 then
                love.graphics.translate(-120,40)
                mouseX = mouseX - (-120)
                mouseY = mouseY - 40
            -- bottom
            elseif soldiercharacter.vertical >=700 then
                love.graphics.translate(-120,-220)
                mouseX = mouseX - (-120)
                mouseY = mouseY - (-220)
            else
                -- print("right else with horizontal: "..soldiercharacter.horizontal..", vertical: "..soldiercharacter.vertical)
                love.graphics.translate(-120,soldiercharacter.vertical >= 520 and -220 or -soldiercharacter.vertical+300)
                mouseX = mouseX - (-120)
                mouseY = mouseY - (soldiercharacter.vertical >= 520 and -220 or -soldiercharacter.vertical+300)
            end
        -- top
        elseif soldiercharacter.vertical <= 260 then
            love.graphics.translate(-soldiercharacter.horizontal+300,40)
            mouseX = mouseX - (-soldiercharacter.horizontal+300)
            mouseY = mouseY - 40
        -- bottom
        elseif soldiercharacter.vertical >= 520 then
            love.graphics.translate(-soldiercharacter.horizontal+300,-220)
            mouseX = mouseX - (-soldiercharacter.horizontal+300)
            mouseY = mouseY - (-220)
        else
            love.graphics.translate(-soldiercharacter.horizontal+300,-soldiercharacter.vertical+300)
            -- love.graphics.translate(-soldiercharacter.horizontal + (gameWidth/2), -soldiercharacter.vertical + (gameHeight/2))
            mouseX = mouseX - (-soldiercharacter.horizontal+300)
            mouseY = mouseY - (-soldiercharacter.vertical+300)
        end

        -- love.graphics.scale(1.4,1.4)
    end
end