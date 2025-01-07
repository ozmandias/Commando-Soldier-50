soldiercharacter = {
    horizontal = 0,
    vertical = 0,
    speed = 100,
    rotateangle = 0,
    horizontalvelocity = 0,
    verticalvelocity = 0,
    soldiercharacterdefaultimage = love.graphics.newImage("assets/soldiercharacter.png"),
    soldiercharacteranimation = love.graphics.newImage("assets/soldiers.png"),
    bullets = 12,
    runanimation = {
        frames={
            love.graphics.newImage("assets/soldiercharacter.png"),
            love.graphics.newImage("assets/soldiercharacterrun1.png"),
            love.graphics.newImage("assets/soldiercharacter.png"),
            love.graphics.newImage("assets/soldiercharacterrun2.png")
        },    
        timer = 0
    },
    animations = {}
}

movekeypress = false

soldiercharacterbullet = require "bullet"
anim8 = require "library/anim8"
windfield = require "library/windfield"

function move(dt)
    if startgame == true then
        if pausegame == false and missionfail == false then
            rotate()
            soldiercharacter.horizontal = soldiercharacter.collider:getX()
            soldiercharacter.vertical = soldiercharacter.collider:getY()
            -- mouseX, mouseY = push:toReal(mouseX, mouseY)
            if love.keyboard.isDown("w") then
                --soldiercharacter.vertical = soldiercharacter.vertical - (soldiercharacter.speed * dt)
                soldiercharacter.verticalvelocity = soldiercharacter.speed * -1
                movekeypress = true
            elseif love.keyboard.isDown("w") == false and love.keyboard.isDown("s") == false then
                soldiercharacter.verticalvelocity = 0
            end
            if love.keyboard.isDown("a") then
                --soldiercharacter.horizontal = soldiercharacter.horizontal - (soldiercharacter.speed * dt)
                soldiercharacter.horizontalvelocity = soldiercharacter.speed * -1
                movekeypress = true
            elseif love.keyboard.isDown("a") == false and love.keyboard.isDown("d") == false then
                soldiercharacter.horizontalvelocity = 0
            end
            if love.keyboard.isDown("s") then
                --soldiercharacter.vertical = soldiercharacter.vertical + (soldiercharacter.speed * dt)
                soldiercharacter.verticalvelocity = soldiercharacter.speed
                movekeypress = true
            elseif love.keyboard.isDown("s") == false and love.keyboard.isDown("w") == false then
                soldiercharacter.verticalvelocity = 0
            end
            if love.keyboard.isDown("d") then
                --soldiercharacter.horizontal = soldiercharacter.horizontal + (soldiercharacter.speed * dt)
                soldiercharacter.horizontalvelocity = soldiercharacter.speed
                movekeypress = true
            elseif love.keyboard.isDown("d") == false and love.keyboard.isDown("a") == false then
                soldiercharacter.horizontalvelocity = 0
            end
            if love.keyboard.isDown("w") == false and love.keyboard.isDown("a") == false and love.keyboard.isDown("s") == false and love.keyboard.isDown("d") == false then
                movekeypress = false
                soldiercharacter.horizontalvelocity = 0
                soldiercharacter.verticalvelocity = 0
            end
            if movekeypress == true then
                --soldiercharacter.image = playrunanimation(dt)
                soldiercharacter.animator = soldiercharacter.animations.run
                love.audio.play(sounds.footsteps)
            else
                --soldiercharacter.image = soldiercharacter.soldiercharacterdefaultimage
                soldiercharacter.animator = soldiercharacter.animations.default
                love.audio.stop(sounds.footsteps)
            end
            soldiercharacter.collider:setLinearVelocity(soldiercharacter.horizontalvelocity,soldiercharacter.verticalvelocity)
            soldiercharacter.animator:update(dt)
        else
            love.audio.stop(sounds.footsteps)
        end
    end
end

function shoot(dt)
    if startgame == true then
        if pausegame == false and missionfail == false then
                bulletdestinationhorizontal = mouseX --love.mouse.getX()
                bulletdestinationvertical = mouseY --love.mouse.getY()
            if love.mouse.isDown(1) then
                --soldiercharacter.image = playshootanimation(dt)
                shoottime = shoottime + 1
                if shoottime == 1 and soldiercharacter.bullets > 0 then
                    soldiercharacter.bullets = soldiercharacter.bullets - 1
                    createbullet(bulletdestinationhorizontal,bulletdestinationvertical,soldiercharacter.collider:getX(),soldiercharacter.collider:getY(),"PlayerBullet")
                    targetcursor = love.graphics.newImage("assets/cursorshoot.png")
                    soldiercharacter.animator = soldiercharacter.animations.shoot
                    love.audio.play(soldiercharacter.shootsound)
                end
            else
                shoottime = 0
                targetcursor = love.graphics.newImage("assets/cursor.png")
            end
        end
    end
end

function rotate()
    soldiercharacter.rotateangle = math.atan2((mouseY --[=[love.mouse.getY()]=] - soldiercharacter.vertical),(mouseX --[=[love.mouse.getX()]=] - soldiercharacter.horizontal)) + 7.8
end

function reload()
    if love.keyboard.isDown("r") then
        reloadtime = reloadtime + 1
        if reloadtime == 1 then
            soldiercharacter.bullets = 12
        end
    else
        reloadtime = 0
    end
end

function playrunanimation(dt)
    times = 0
    currentrunanimationframe = 1
    soldiercharacter.runanimation.timer = soldiercharacter.runanimation.timer + dt
    if soldiercharacter.runanimation.timer >= 0.1 then
        for i=0,dt do
            times = times + 1
        end
        currentrunanimationframe = currentrunanimationframe + 1
        if currentrunanimationframe > 3 then
            currentrunanimationframe = 1
        end
        soldiercharacter.runanimation.timer = 0
    end
    currentrunanimationframe = soldiercharacter.runanimation.frames[currentrunanimationframe]
    return currentrunanimationframe 
end

function playshootanimation(dt)
    currentshootanimationframe = love.graphics.newImage("assets/soldiercharactershoot.png")
    return currentshootanimationframe
end

function printplayerposition(dt)
    if love.keyboard.isDown("e") then
        printtime = printtime + 1
        if printtime==1 then
            horizontalpositiontext = tostring(soldiercharacter.horizontal)
            verticalpositiontext = tostring(soldiercharacter.vertical)
            playerpositiontext = string.format("{x=%.1f"..",y=%.1f".."},",horizontalpositiontext,verticalpositiontext)
            print(playerpositiontext)
        end
    else
        printtime = 0
    end
end

function setupplayer(physicsworld)
    soldiercharacter.image = love.graphics.newImage("assets/soldiercharacter.png")
    soldiercharacter.grid = anim8.newGrid(50,50,soldiercharacter.soldiercharacteranimation:getWidth(),soldiercharacter.soldiercharacteranimation:getHeight())
    soldiercharacter.animations.default = anim8.newAnimation(soldiercharacter.grid(1,3),0.1)
    soldiercharacter.animations.run = anim8.newAnimation(soldiercharacter.grid(1,3, 3,3, 1,3, 4,3),0.1)
    soldiercharacter.animations.shoot = anim8.newAnimation(soldiercharacter.grid(2,3),0.1)
    soldiercharacter.animatior = soldiercharacter.animations.default
    soldiercharacter.collider = physicsworld:newRectangleCollider(400,400,20,20)
    soldiercharacter.collider:setFixedRotation(true)
    soldiercharacter.collider:setCollisionClass("Player")
    soldiercharacter.horizontal = 400
    soldiercharacter.vertical = 400
    soldiercharacter.bullets = 32
    soldiercharacter.footstepssound = love.audio.newSource("assets/footsteps.wav","stream")
    soldiercharacter.footstepssound:setLooping(true)
    soldiercharacter.shootsound = love.audio.newSource("assets/shoot.wav","static")
end