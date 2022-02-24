bulletprefab = {
    bulletanimation = love.graphics.newImage("assets/bullet.png"),
    horizontal = 0,
    vertical = 0,
    speed = 600,
    rotateangle = 0,
    animations = {}
}

bulletobject = {}
bulletobject.__index = bulletprefab

bullets = {}

function createbullet(destinationhorizontal,destinationvertical,originhorizontal,originvertical,collisionclassname)
    newbullet = bulletprefab.new()
    --print("Bullet created")
    newbullet.image = love.graphics.newImage("assets/bulletimage.png")
    newbullet.grid = anim8.newGrid(16,22,newbullet.bulletanimation:getWidth(),newbullet.bulletanimation:getHeight())
    newbullet.animations.bullet = anim8.newAnimation(newbullet.grid(1,1, 2,1),0.2)
    newbullet.animator = newbullet.animations.bullet
    newbullet.collider = windfieldworld:newRectangleCollider(originhorizontal,originvertical,10,10)
    newbullet.collider:setFixedRotation(true)
    newbullet.collider:setCollisionClass(collisionclassname)
    newbullet.collisionclass = collisionclassname
    newbullet.horizontal = originhorizontal
    newbullet.vertical = originvertical
    newbullet.rotateangle = math.atan2((destinationvertical - newbullet.vertical),(destinationhorizontal - newbullet.horizontal))
    newbullet.directionhorizontal = math.cos(newbullet.rotateangle) * newbullet.speed
    newbullet.directionvertical = math.sin(newbullet.rotateangle) * newbullet.speed
    newbullet.bullethitsound = love.audio.newSource("assets/bullethit.wav","static")
    table.insert(bullets,newbullet)
    setbulletnumber()
end

function updatebullet(dt)
    if table.getn(bullets) > 0 then
        if pausegame == false then
            for i=1,table.getn(bullets) do
                bullets[i].horizontal = bullets[i].horizontal + (bullets[i].directionhorizontal * dt)
                bullets[i].vertical = bullets[i].vertical + (bullets[i].directionvertical * dt)
                bullets[i].collider:setPosition(bullets[i].horizontal,bullets[i].vertical)
            end
        end
    end
end

function setbulletnumber()
    for i=1,table.getn(bullets) do
        bullets[i].bulletnumber = i
    end
end

function deletebullet(bulletnumberofbullet)
    bullets[bulletnumberofbullet].collider:destroy()
    table.remove(bullets,bulletnumberofbullet)
    setbulletnumber()
end

function bulletprefab.new()
    newbulletobject = setmetatable({},bulletobject) 
    return newbulletobject
end