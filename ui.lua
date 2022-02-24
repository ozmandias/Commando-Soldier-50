loveframes = require "library/loveframes"

--loveframesbutton = loveframes.Create("button")
--loveframesbutton:SetPos(10,10)

inconsolatafont = love.graphics.newFont("assets/inconsolataregular.ttf",12)
loveframes.GetActiveSkin().directives.text_default_font = love.graphics.newFont("assets/inconsolataregular.ttf",18)

finalprojecttitleimage = loveframes.Create("image")
finalprojecttitleimage:SetImage("assets/finalprojecttitle.png")
finalprojecttitleimage:SetPos(440,140)
finalprojecttitleimage:SetVisible(true)

finalprojectsubtitletext = loveframes.Create("text")
finalprojectsubtitletext:SetText({{color={1,1,1}},"A CS50 Game"})
finalprojectsubtitletext:SetPos(580,220)

mainmenupanel = loveframes.Create("panel")
mainmenupanel:SetWidth(480)
mainmenupanel:SetHeight(160)
mainmenupanel:SetPos(400,260)

descriptiontext = loveframes.Create("text")
--descriptiontext:SetText("hello\nworld")
descriptiontext:SetText({{color={1,1,1}},"You are an elite commando soldier from\nmiltiary base CS50(Commando Special-forces 50).\nYou only have one mission:To eliminate every enemy\nin the battleground.One shot is one kill\nfor everyone.Avoid getting hit and be\nthe last one stading."})
--descriptiontext:SetDefaultColor("#ffffff")
descriptiontext:SetParent(mainmenupanel)
descriptiontext:SetShadow(true)
descriptiontext:SetShadowColor(1,1,1)
descriptiontext:SetShadowOffsets(0,1)
descriptiontext:Center()
descriptiontext:SetY(20)

finalprojectcontrolsimage = loveframes.Create("image")
finalprojectcontrolsimage:SetImage("assets/finalprojectcontrols.png")
finalprojectcontrolsimage:SetPos(520,350)

finalprojectmainmenutext = loveframes.Create("text")
finalprojectmainmenutext:SetText({{color={1,1,1}},"Press 'Enter' to Play/Pause\nPress 'Esc' to Exit"})
finalprojectmainmenutext:SetPos(520,580)

finalprojectdevelopertext = loveframes.Create("text")
finalprojectdevelopertext:SetText({{color={1,1,1}},"Developed by Myo Si Thu"})
finalprojectdevelopertext:SetPos(520,690)

bullettext = loveframes.Create("text")
bullettext:SetFont(inconsolatafont)
bullettext:SetText({{color={1,1,1}},soldiercharacter.bullets.."/12"})
bullettext:SetPos(love.mouse.getX(),love.mouse.getY())
bullettext:SetAlwaysUpdate(true)

pausetext = loveframes.Create("text")
pausetext:SetFont(inconsolatafont)
pausetext:SetText({{color={1,1,1}},"Paused"})
pausetext:SetPos(soldiercharacter.horizontal,soldiercharacter.vertical + 10)

missioncompletetext = loveframes.Create("text")
missioncompletetext:SetFont(inconsolatafont)
missioncompletetext:SetText({{color={1,1,1}},"Mission Complete"})
missioncompletetext:SetPos(soldiercharacter.horizontal,soldiercharacter.vertical + 10)

missionfailtext = loveframes.Create("text")
missionfailtext:SetFont(inconsolatafont)
missionfailtext:SetText({{color={1,1,1}},"Mission Failed"})
missionfailtext:SetPos(soldiercharacter.horizontal,soldiercharacter.vertical + 10)

function updatebullettext()
    if startgame == true then
        bullettext:SetPos(love.mouse.getX()+8,love.mouse.getY()+10)
        bullettext:SetText({{color={1,1,1}},soldiercharacter.bullets.."/12"})
        bullettext:SetVisible(true)
    else
        bullettext:SetVisible(false)
    end
end

function updatepausetext()
    pausetext:SetPos(soldiercharacter.horizontal - 20,soldiercharacter.vertical + 10)
    if pausegame == true then
        pausetext:SetVisible(true)
    else
        pausetext:SetVisible(false)
    end
end

function updatemainmenu()
    if startgame == true then
        finalprojecttitleimage:SetVisible(false)
        finalprojectsubtitletext:SetVisible(false)
        mainmenupanel:SetVisible(false)
        descriptiontext:SetVisible(false)
        finalprojectcontrolsimage:SetVisible(false)
        finalprojectmainmenutext:SetVisible(false)
        finalprojectdevelopertext:SetVisible(false)
    end
end

function updatemissioncompletetext()
    missioncompletetext:SetPos(soldiercharacter.horizontal - 40,soldiercharacter.vertical + 10)
    if missioncomplete == true then
        missioncompletetext:SetVisible(true)
    else
        missioncompletetext:SetVisible(false)
    end
end

function updatemissionfailtext()
    missionfailtext:SetPos(soldiercharacter.horizontal - 40,soldiercharacter.vertical + 10)
    if missionfail == true then
        missionfailtext:SetVisible(true)
    else
        missionfailtext:SetVisible(false)
    end
end