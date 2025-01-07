enemysoldier = {
    speed = 20,
    enemysoldieranimation = love.graphics.newImage("assets/soldiers.png"),
    rotateangle = 0,
    animations = {},
    playerandenemydistance = 0,
    bullets = 32,
    enemyshoottime = 0,
    enemyshoottimer = 0,
    enemyreloadtimer = 0
}

enemyobject = {}
enemyobject.__index = enemysoldier

enemies = {}
setmetatable(enemies,enemyobject)
enemyobject.__mode = "k"

function enemymove(location,dt)
    if pausegame == false and missionfail == false then
        enemychecksplayer(location)
        enemies[location].horizontal = enemies[location].collider:getX()
        enemies[location].vertical = enemies[location].collider:getY()
        if enemies[location].playerandenemydistance <= 360 then
            enemies[location].rotateangle = math.atan2((soldiercharacter.vertical - enemies[location].vertical),(soldiercharacter.horizontal - enemies[location].horizontal)) + 7.8
            enemies[location].collider:setLinearVelocity((soldiercharacter.horizontal-enemies[location].horizontal) * enemies[location].speed * dt,(soldiercharacter.vertical-enemies[location].vertical) * enemies[location].speed * dt)
            enemies[location].animator = enemies[location].animations.run
            love.audio.play(enemies[location].footstepssound)
            if enemies[location].playerandenemydistance <= 200 then
                enemyshoot(location,dt)
                love.audio.stop(enemies[location].footstepssound)
            end
        else
            enemies[location].collider:setLinearVelocity(0,0)
            enemies[location].animator = enemies[location].animations.default
            love.audio.stop(enemies[location].footstepssound)
        end
        enemies[location].animator:update(dt)
    end
end

function enemyshoot(locationinenemies,dt)
    if pausegame == false and missionfail == false then
        enemies[locationinenemies].collider:setLinearVelocity(0,0)
        enemies[locationinenemies].enemyshoottimer = enemies[locationinenemies].enemyshoottimer + dt
        enemies[locationinenemies].enemyshoottime = enemies[locationinenemies].enemyshoottime + 1
        if enemies[locationinenemies].enemyshoottime == 1 and enemies[locationinenemies].bullets > 0 then
            enemies[locationinenemies].bullets = enemies[locationinenemies].bullets - 1
            createbullet(soldiercharacter.horizontal,soldiercharacter.vertical,enemies[locationinenemies].collider:getX(),enemies[locationinenemies].collider:getY(),"EnemyBullet")
            love.audio.play(enemies[locationinenemies].shootsound)
        end
        --print("enemies["..locationinenemies.."].enemyshoottimer:"..tostring(enemies[locationinenemies].enemyshoottimer))
        -- enemies[locationinenemies].animator = enemies[locationinenemies].animations.shoot
        if enemies[locationinenemies].enemyshoottimer >= 0.5 then
            enemies[locationinenemies].enemyshoottimer = 0
            enemies[locationinenemies].enemyshoottime = 0
        end
    end
end

function enemychecksplayer(location)
    enemysoldier.playerandenemydistance = finddistance(soldiercharacter.horizontal,soldiercharacter.vertical,enemies[location].horizontal,enemies[location].vertical)
end

function enemyreload(locationinenemies,dt)
    if enemies[locationinenemies].bullets == 0 then
        enemies[locationinenemies].enemyreloadtimer = enemies[locationinenemies].enemyreloadtimer + dt
        if enemies[locationinenemies].enemyreloadtimer >= 1 then
            enemies[locationinenemies].bullets = 32
        end
    else
        enemies[locationinenemies].enemyreloadtimer = 0
    end
end

function setupenemy(physicsworld)
    enemypositions = {
        {x=1139.1,y=376.7},{x=1112.4,y=513.3},{x=1092.4,y=128.3},{x=687.7,y=55.0},{x=424.4,y=-6.6},{x=59.4,y=705.7},
        {x=147.7,y=787.3},{x=346.0,y=895.6},{x=586.0,y=878.9},{x=1055.6,y=905.7},{x=1240.6,y=839.0},{x=1348.4,y=32.4}
    }
    for i=1,table.getn(enemypositions) do
        newenemy = enemysoldier.new()
        newenemy.image = love.graphics.newImage("assets/enemy.png")
        newenemy.grid = anim8.newGrid(50,50,newenemy.enemysoldieranimation:getWidth(),newenemy.enemysoldieranimation:getHeight())
        newenemy.animations.default = anim8.newAnimation(newenemy.grid(1,1),0.1)
        newenemy.animations.run = anim8.newAnimation(newenemy.grid(1,1, 3,1, 1,1, 4,1),0.4)
        newenemy.animations.shoot = anim8.newAnimation(newenemy.grid(2,1),0.1)
        newenemy.animator = newenemy.animations.default
        newenemy.collider = physicsworld:newRectangleCollider(enemypositions[i].x,enemypositions[i].y,20,20)
        newenemy.collider:setFixedRotation(true)
        newenemy.collider:setCollisionClass("Enemy")
        newenemy.horizontal = enemypositions[i].x
        newenemy.vertical = enemypositions[i].y
        newenemy.rotateangle = math.random(1,360)
        newenemy.footstepssound = love.audio.newSource("assets/footsteps.wav","stream")
        newenemy.footstepssound:setLooping(true)
        newenemy.shootsound = love.audio.newSource("assets/shoot.wav","static")
        newenemy.hurtsound = love.audio.newSource("assets/enemyhurt.wav","static")
        table.insert(enemies,newenemy)
        --enemies[newenemy] = newenemy
        setenemynumber()
    end
end

function setenemynumber()
    for i=1,table.getn(enemies) do
        enemies[i].enemynumber = i
    end
end

function deleteenemy(enemynumberofenemy)
    enemies[enemynumberofenemy].collider:destroy()
    love.audio.stop(enemies[enemynumberofenemy].footstepssound)
    table.remove(enemies,enemynumberofenemy)
    --enemies[self] = nil
    setenemynumber()
end

function finddistance(destinationhorizontal,destinationvertical,originhorizontal,originvertical)
    distancehorizontal = destinationhorizontal - originhorizontal
    distancevertical = destinationvertical - originvertical
    destinationandorigindistance = math.sqrt(distancehorizontal * distancehorizontal + distancevertical * distancevertical)
    return destinationandorigindistance
end

function enemysoldier.new()
    newenemyobject = setmetatable({},enemyobject)
    return newenemyobject
end