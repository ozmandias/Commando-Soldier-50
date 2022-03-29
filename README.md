# Commando Soldier 50
#### Video Demo: https://youtu.be/72_ZxNi2ViU
#### Description:
Commando Soldier 50 (CS50) is a top down shooter survival game where you play as an elite commando whose task is to eliminate enemies until no one is left in battleground.
Beware that both you and enemies can't take one shot and that will result death.
Perform your task wisely and sneakily and as adaptatively as possible.

#### Source Code
##### player.lua
Contains the code for elite commando soldier player character.
**move()** - moves the player character when user presses W,A,S,D keys

**shoot()** - shoots a bullet from the position of the player character to the forward direction of the player character when user clicks left mouse

**reload()** - reloads the gun of player character

**playrunanimation()** - plays run animation of the player character

**playshootanimation()** - plays shoot animation of the player character

**printplayerposition()** - prints position of the player character when user presses E key for debugging purpose

**setupplayer()** - sets the data values of the player character at the start of the game


#####  main.lua
Contains the code for the whole game.
**setupgame()** - sets the data values of the game environment at the start of the game

**setupphysics()** - sets the data values of the physics in the game at the start of the game

**checkcollision()** - checks collisions between player character, enemy character, bullet and tree

**checkmissioncomplete()** - checks if player eliminated every enemy in the game

##### enemy.lua
Contains the code for the enemy characters in the game.
**enemymove()** - moves the enemy character when player is at a specific distance

**enemyshoot()** - shoots a bullet from the position of the enemy chracter to the position of the player

**enemycheckplayer()** - checks if player is at a specific distance

**enemyreload()** - reloads the gun of enemy after shooting 32 bullets

**setupenemy()** - sets the data values of the enemy character at the start of the game

**setenemynumber()** - specify an index number to enemy for deleteenemy()

**deleteenemy()** - deletes enemy based on index number

**finddistance()** - calculates distance between player character and enemy character

##### bullet.lua
Contains the code for bullet that can be used by both player and enemy.
**createbullet()** - creates a bullet whenever player character or enemy character shoots

**updatebullet()** - updates the position of the bullet

**setbulletnumber()** - specify an index number to bullet for deletebullet()

**deletebullet()** - deletes bullet based on index number

#### sound.lua
Contains the code for sounds in the game.\
**setupsound()** - sets the data values of sounds at the start of the game

#### config.lua
Contains configurations for the game.\
**love.conf()** - sets the configurations of the game for debugging purpose

#### tree.lua
Contains the code for tree in the game that can be used as cover.\
**setuptrees()** - sets the data values of tress in the game at the start of the game

#### ui.lua
Contains the code for User Interface in the game.\
**updatebullettext()** - updates the text that displays the current bullet amount of the player character

**updatepausetext()** - updates the text that displays the pause status of the game

**updatemainmenu()** - updates main menu when  the game starts

**updatemissioncompletetext()** - updates the text that displays the mission complete status of the player character

**updatemissionfailtext()** - updates the text that dispalys the mission failed status of the player character
#### wait.lua
Contains the code to pause the code for specific amount of time.\
**wait()** - pauses program for a specific amount of time


#### Libraries Used
##### anim8
Used for animating player and enemycharacters.
##### windfield
Used for simple physics calculations in the game.
##### loveframes
Used for simple User Interface in the game.
##### push
Used for adjusting game window size.
#### Controls
W - Move Up\
A - Move Left\
S - Move Down\
D - Move Right\
Mouse - Aim\
Mouse Left Click - Shoot

#### Running the Game
Drag and Drop CommandoSoldier50 Folder onto Love.exe inside Love2D Folder or run CommandoSoldier50.exe file inside Love2D Folder

###### Developed by - Myo Si Thu
