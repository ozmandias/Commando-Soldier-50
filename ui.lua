loveframes = require "library/loveframes"

--loveframesbutton = loveframes.Create("button")
--loveframesbutton:SetPos(10,10)

inconsolatafont = love.graphics.newFont("assets/inconsolataregular.ttf",22)--12
loveframes.GetActiveSkin().directives.text_default_font = love.graphics.newFont("assets/inconsolataregular.ttf",18)

finalprojecttitleimage = loveframes.Create("image")
finalprojecttitleimage:SetImage("assets/finalprojecttitle.png")
-- print(finalprojecttitleimage:GetImageSize())
finalprojecttitleimage:SetPos((gameWidth/2) - (finalprojecttitleimage:GetImageWidth()/2),50)
finalprojecttitleimage:SetVisible(true)

finalprojectsubtitletext = loveframes.Create("text")
finalprojectsubtitletext:SetFont(inconsolatafont)
finalprojectsubtitletext:SetText({{color={1,1,1}},"A CS50 Game"})
finalprojectsubtitletext:Center()
finalprojectsubtitletext_width = finalprojectsubtitletext:GetFont():getWidth(finalprojectsubtitletext:GetText())
-- print("finalprojectsubtitletext_width: "..finalprojectsubtitletext_width)
finalprojectsubtitletext:SetPos((gameWidth/2) - (finalprojectsubtitletext_width/2),150)

mainmenupanel = loveframes.Create("panel")
local mainmenupanelwidth = 480
local mainmenupanelheight = 140
mainmenupanel:SetWidth(mainmenupanelwidth)
mainmenupanel:SetHeight(mainmenupanelheight)
mainmenupanel:SetPos((gameWidth/2) - (mainmenupanelwidth/2),200)

descriptiontext = loveframes.Create("text")
--descriptiontext:SetText("hello\nworld")
descriptiontext:SetText({{color={0,0,0}},"You are an elite commando soldier from\nmiltiary base CS50(Commando Special-Forces 50).\nYou only have one mission: Eliminate every enemy\nforces in the battleground! One shot is one kill\nto everyone. Avoid getting shot and be the last one\nstaying alive!"})
--descriptiontext:SetDefaultColor("#ffffff")
descriptiontext:SetParent(mainmenupanel)
descriptiontext:SetShadow(true)
descriptiontext:SetShadowColor(0,0,0)
descriptiontext:SetShadowOffsets(0,1)
descriptiontext:Center()
descriptiontext:SetY(10)

finalprojectcontrolsimage = loveframes.Create("image")
finalprojectcontrolsimage:SetImage("assets/finalprojectcontrols.png")
finalprojectcontrolsimage:SetPos((gameWidth/2) - (finalprojectcontrolsimage:GetImageWidth()/2),300)

finalprojectmainmenutext = loveframes.Create("text")
finalprojectmainmenutext:SetFont(inconsolatafont)
finalprojectmainmenutext:SetText({{color={1,1,1}},"Press 'Enter' to Play/Pause\nPress 'Esc' to Exit"})
finalprojectmainmenutext_width = finalprojectmainmenutext:GetFont():getWidth(finalprojectmainmenutext:GetText())
finalprojectmainmenutext:SetPos((gameWidth/2) - (finalprojectmainmenutext_width/2),550)

finalprojectdevelopertext = loveframes.Create("text")
finalprojectdevelopertext:SetFont(inconsolatafont)
finalprojectdevelopertext:SetText({{color={1,1,1}},"Developer - Myo Si Thu"})
finalprojectdevelopertext_width = finalprojectdevelopertext:GetFont():getWidth(finalprojectdevelopertext:GetText())
finalprojectdevelopertext:SetPos((gameWidth/2) - (finalprojectdevelopertext_width/2),650)

bullettext = loveframes.Create("text")
bullettext:SetFont(inconsolatafont)
bullettext:SetText({{color={1,1,1}},soldiercharacter.bullets.."/12"})
bullettext:SetPos(mouseX,mouseY + 10)
bullettext:SetAlwaysUpdate(true)

mouseXYtext = loveframes.Create("text")
mouseXYtext:SetFont(inconsolatafont)
mouseXYtext:SetText({{color={1,1,1}},"mouseX: "..mouseX..", mouseY: "..mouseY})
mouseXYtext:SetPos(mouseX,mouseY + 25)
mouseXYtext:SetVisible(false)

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
        bullettext:SetPos(mouseX,mouseY+10)
        bullettext:SetText({{color={1,1,1}},soldiercharacter.bullets.."/12"})
        bullettext:SetVisible(true)
    else
        bullettext:SetVisible(false)
    end
end

function updatemouseXYtext()
    if startgame == true then
        mouseXYtext:SetPos(mouseX,mouseY + 25)
        mouseXYtext:SetText({{color={1,1,1}},"mouseX: "..mouseX..", mouseY: "..mouseY})
        mouseXYtext:SetVisible(true)
    else
        mouseXYtext:SetVisible(false)
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