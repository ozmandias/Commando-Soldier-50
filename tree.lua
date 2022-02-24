treeobject = {}

function setuptrees(treephysicsworld)
    treesimage = love.graphics.newImage("assets/trees.png")

    treepositions = {
        {x=41.6,y=30.09},{x=108.2,y=31.5},{x=154.9,y=4.8},{x=206.6,y=24.8},{x=288.7,y=-1.9},{x=368.8,y=-6.9},{x=488.7,y=3.1},{x=567.0,y=11.5},{x=617.0,y=38.2},{x=662.0,y=13.3},
        {x=727.0,y=9.9},{x=777.0,y=61.6},{x=827.0,y=23.2},{x=920.3,y=39.9},{x=1007.0,y=24.9},{x=1025.4,y=96.6},{x=1088.7,y=21.6},{x=1132.0,y=76.7},{x=1187.0,y=153.4},{x=1267.0,y=146.7},
        {x=1267.0,y=223.4},{x=1322.0,y=210.0},{x=1342.0,y=261.7},{x=1355.3,y=171.7},{x=75.0,y=365.0},{x=75.0,y=291.8},{x=146.6,y=178.5},{x=231.6,y=135.3},{x=301.6,y=143.6},{x=366.7,y=175.2},
        {x=381.7,y=96.9},{x=443.4,y=118.5},{x=500.1,y=196.8},{x=533.4,y=126.7},{x=600.1,y=158.4},{x=710.0,y=178.4},{x=766.8,y=178.4},{x=825.2,y=195.0},{x=901.9,y=220.0},{x=988.6,y=245.1},
        {x=111.7,y=531.7},{x=136.7,y=615.1},{x=218.4,y=645.1},{x=191.7,y=713.4},{x=53.3,y=780.1},{x=83.3,y=838.5},{x=156.6,y=863.5},{x=240.1,y=730.1},{x=290.1,y=695.1},{x=243.4,y=781.8},
        {x=316.6,y=751.9},{x=385.0,y=763.5},{x=495.0,y=778.5},{x=570.0,y=753.5},{x=598.3,y=798.5},{x=658.3,y=743.5},{x=753.3,y=705.3},{x=915.0,y=653.7},{x=976.7,y=637.0},{x=1058.3,y=625.4},
        {x=1156.6,y=615.4},{x=789.9,y=878.8},{x=878.3,y=843.8},{x=986.6,y=808.8},{x=1069.9,y=747.1},{x=1146.6,y=772.1},{x=1241.6,y=738.7},{x=1329.8,y=691.9},{x=1351.5,y=796.9},{x=1314.9,y=820.2}
    }
    
    for i=1,70 do
        gametreeobject = {}
        treeobjectimage = love.graphics.newImage("assets/tree.png")
        treeobjectcollider = treephysicsworld:newCircleCollider(treepositions[i].x,treepositions[i].y,20)
        treeobjectcollider:setFixedRotation(true)
        treeobjectcollider:setType("static")
        treeobjectcollider:setCollisionClass("Tree")
        treeobjecthorizontal = treepositions[i].x
        treeobjectvertical = treepositions[i].y
        table.insert(gametreeobject,treeobjectimage)
        table.insert(gametreeobject,treeobjectcollider)
        table.insert(gametreeobject,treeobjecthorizontal)
        table.insert(gametreeobject,treeobjectvertical)
        table.insert(treeobject, gametreeobject)
    end
end