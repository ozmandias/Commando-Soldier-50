sounds = {}

function setupsound()
    sounds.footsteps = love.audio.newSource("assets/footsteps.wav","stream")
    sounds.shoot = love.audio.newSource("assets/shoot.wav","static")
    sounds.bullethit = love.audio.newSource("assets/bullethit.wav","static")
    sounds.playerhurt = love.audio.newSource("assets/playerhurt.wav","static")
    sounds.enemyhurt = love.audio.newSource("assets/enemyhurt.wav","static")
    sounds.epicmusic = love.audio.newSource("assets/epicmusic.mp3","stream")
    sounds.superepicmusic = love.audio.newSource("assets/superepicmusic.mp3","stream")
    sounds.missioncompletemusic = love.audio.newSource("assets/missioncomplete.mp3","stream")
    sounds.missionfailmusic = love.audio.newSource("assets/missionfail.mp3","stream")
    sounds.footsteps:setLooping(true)
    sounds.epicmusic:setLooping(true)
    sounds.superepicmusic:setLooping(true)
    sounds.missioncompletemusic:setLooping(true)
    sounds.missionfailmusic:setLooping(true)
end