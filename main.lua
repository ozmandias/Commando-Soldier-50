require "player"
require "enemy"
require "tree"
require "sound"
require "ui"

windfieldworld = windfield.newWorld()
printtime = 0
startgame = false
pausegame = false
missioncomplete = false
missionfail = false

function love.load()
    setupgame()
    setupphysics()
    setupplayer(windfieldworld)
    setupenemy(windfieldworld)
    setuptrees(windfieldworld)
    --print(table.getn(enemies))
    setupsound()
    love.audio.play(sounds.epicmusic)
end

function love.update(dt)
    move(dt)
    shoot(dt)
    reload()
    updatebullet(dt)
    --treeobject.horizontal = treeobject.collider:getX() - treeobject.image:getWidth()/2
    --treeobject.vertical = treeobject.collider:getY() - treeobject.image:getHeight()/2
    windfieldworld:update(dt)
    for i=1,table.getn(enemies) do
        enemymove(i,dt)
        enemyreload(i,dt)
    end
    if table.getn(bullets) > 0 then
        for i=1,table.getn(bullets) do
            bullets[i].animator:update(dt)
        end
    end
    checkcollision()
    --printplayerposition(dt)
    loveframes.update()
    updatebullettext()
    updatepausetext()
    checkmissioncomplete()
    updatemissioncompletetext()
    updatemissionfailtext()
end

function love.draw()
    --love.graphics.print("Hello World",300,200)
    if soldiercharacter.horizontal <= 310 then
        if soldiercharacter.vertical <= 260 then
            love.graphics.translate(0,40)
        elseif soldiercharacter.vertical >=700 then
            love.graphics.translate(0,-400)
        else
            love.graphics.translate(0,-soldiercharacter.vertical+300)
        end
    elseif soldiercharacter.horizontal >=640 then
        if soldiercharacter.vertical <=260 then
            love.graphics.translate(-360,40)
        elseif soldiercharacter.vertical >=700 then
            love.graphics.translate(-360,-400)
        else
            love.graphics.translate(-360,-soldiercharacter.vertical+300)
        end
    elseif soldiercharacter.vertical <= 260 then
        love.graphics.translate(-soldiercharacter.horizontal+300,40)
    elseif soldiercharacter.vertical >= 700 then
        love.graphics.translate(-soldiercharacter.horizontal+300,-400)
    else
        love.graphics.translate(-soldiercharacter.horizontal+300,-soldiercharacter.vertical+300)
    end
    love.graphics.scale(1.4,1.4)
    love.graphics.draw(backgroundimage,0,-40)
    if table.getn(bullets) > 0 then 
        for i=1,table.getn(bullets) do
            bullets[i].animator:draw(bullets[i].bulletanimation,bullets[i].horizontal,bullets[i].vertical,bullets[i].rotateangle+7.8,0.6,0.6,bullets[i].image:getWidth()/2,bullets[i].image:getHeight()/2)
        end
    end
    --love.graphics.draw(soldiercharacter.image,soldiercharacter.horizontal,soldiercharacter.vertical,soldiercharacter.rotateangle,1,1,soldiercharacter.image:getWidth()/2,soldiercharacter.image:getHeight()/2)
    --love.graphics.print("player x:"..soldiercharacter.horizontal..", ".."player y:"..soldiercharacter.vertical,soldiercharacter.horizontal,soldiercharacter.vertical)
    if missionfail == false then
        if soldiercharacter.animator == soldiercharacter.animations.default or soldiercharacter.animator == soldiercharacter.animations.run or soldiercharacter.animatior == soldiercharacter.animations.shoot then
            soldiercharacter.animator:draw(soldiercharacter.soldiercharacteranimation,soldiercharacter.horizontal,soldiercharacter.vertical,soldiercharacter.rotateangle,1,1,soldiercharacter.image:getWidth()/2,soldiercharacter.image:getHeight()/2)
        end
    end
    for i=1,table.getn(enemies) do
        enemies[i].animator:draw(enemies[i].enemysoldieranimation,enemies[i].horizontal,enemies[i].vertical,enemies[i].rotateangle,1,1,enemies[i].image:getWidth()/2,enemies[i].image:getHeight()/2)
    end
    love.graphics.draw(treesimage,0,-40)
    if startgame == true then
        love.graphics.draw(targetcursor,love.mouse.getX(),love.mouse.getY(),0,1,1,targetcursor:getWidth()/2,targetcursor:getHeight()/2)
    end
    --love.graphics.print(enemysoldier.playerandenemydistance,enemysoldier.horizontal,enemysoldier.vertical)
    --windfieldworld:draw()
    --love.graphics.print("playerrotateangle:"..soldiercharacter.rotateangle,soldiercharacter.horizontal,soldiercharacter.vertical)
    loveframes.draw()
end

function love.keypressed(key)
    if key == "return" then
        if startgame == false then
            startgame = true
            love.audio.stop(sounds.epicmusic)
            love.audio.play(sounds.superepicmusic)
            updatemainmenu()
        else
            if pausegame == false then
                pausegame = true
            else
                pausegame = false
            end
        end
    end
    if key=="escape" then
        love.event.quit()
    end
    loveframes.keypressed(key,isrepeat)
end

function setupgame()
    backgroundimage = love.graphics.newImage("assets/love2dgamebackground.png")
    love.window.setMode(1400,980,{centered=true,resizable=true,fullscreen=true,minwidth=512,minheight=512})
    targetcursor = love.graphics.newImage("assets/cursor.png")
    love.mouse.setRelativeMode(true)
end

function setupphysics()
    windfieldworld:addCollisionClass("Player")
    windfieldworld:addCollisionClass("Enemy")
    windfieldworld:addCollisionClass("Tree")
    windfieldworld:addCollisionClass("PlayerBullet")
    windfieldworld:addCollisionClass("EnemyBullet")
end

function checkcollision()
    if soldiercharacter.collider:enter("Enemy") then
        --print("Enemy Collision Entered")
    end
    if soldiercharacter.collider:enter("Tree") then
        --print("Tree Collision Entered")
    end
    if soldiercharacter.collider:enter("EnemyBullet") then
        --print("EnemyBullet Collision Entered")
        love.audio.play(sounds.playerhurt)
        missionfail = true
        love.audio.stop(sounds.superepicmusic)
        love.audio.play(sounds.missionfailmusic)
    end
    for i=1,table.getn(enemies) do
        if enemies[i].collider:enter("PlayerBullet") then
            --print("PlayerBullet Collision Entered")
            love.audio.play(enemies[i].hurtsound)
            deleteenemy(enemies[i].enemynumber)
            --print(table.getn(enemies))
            break
        end
    end
    for i=1,table.getn(bullets) do
        if bullets[i].collider:enter("Tree") then
            love.audio.play(bullets[i].bullethitsound)
            deletebullet(bullets[i].bulletnumber)
            break
        elseif bullets[i].collisionclass == "PlayerBullet" and bullets[i].collider:enter("Enemy") then
            love.audio.play(bullets[i].bullethitsound)
            deletebullet(bullets[i].bulletnumber)
            break
        elseif bullets[i].collisionclass == "EnemyBullet" and bullets[i].collider:enter("Player") then
            love.audio.play(bullets[i].bullethitsound)
            deletebullet(bullets[i].bulletnumber)
            break
        elseif bullets[i].horizontal >= 1400 or bullets[i].horizontal <= 0 or bullets[i].vertical >= 980 or bullets[i].vertical <= -60 then
            deletebullet(bullets[i].bulletnumber)
            break
        end
    end
end

function checkmissioncomplete()
    if table.getn(enemies) == 0 then
        missioncomplete = true
        love.audio.stop(sounds.superepicmusic)
        love.audio.play(sounds.missioncompletemusic)
    end
end

function love.mousepressed(x,y,button)
    loveframes.mousepressed(x,y,button)
end

function love.mousereleased(x,y,button)
    loveframes.mousereleased(x,y,button)
end

function love.keyreleased(key)
    loveframes.keyreleased(key)
end

function love.textinput(text)
    loveframes.textinput(text)
end