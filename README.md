# MKS22X-FinalProject
AP CS Final Project

Project description:

Vargithor is a bullet hell game. To run, double click the Vargithor folder, double click Varigthor.pde, and when the code file opens, go to the top left corner where you see the play button. Click it to run the game. Press the How-To button to look at the keybinds and press New Game to start playing. Enjoy!

Development log:

June 4th 2019:
=======================================================================================
Michael Zhang:
* Finish room progression
* Added createRoom() method to Room class to generate a room based on how many rooms you’ve completed
* Randomly generate enemies on each room
* Integrated boss level into rooms
* Gave player bullets a maximum range so they don’t travel forever 
* Gave player strength upon killing a boss
* Created a keybind for godmode (for demos)
* Readded health regeneration to lower the game’s difficulty 
* Fixed a bug that made the end screen not trigger properly once the player dies by adding an entityID field to each entity
* Removed separate shooting modes

Derek Lao:
* Added bulletLife, bulletSpeed, bulletStrength, to all monster shoot methods
* Added ringOfRingsShoot, where the monster would create a ring of entities (not visible) and those entities would shoot circular
* Added lifeSpan for bullets, reason being that the bullets can despawn after a limited amount of time, giving them range and also preventing an overload of bullets on the screen slowing down the game
* Improved player bullet collision for larger bullets by fixing the equation
* Made bullet die() true if the lifeTime is greater than or equal to lifeSpan
* Nullpointer exception fixed, bug caused by accidental switching of initialization between lifeTime and lifeSpan
* Edited dance phase to give player more room to dodge
* Fixed leadPlayerShoot by using discriminant or using the monsterPlayerVelocity
* Added regenerateHealth() for player to regenerate health. Tweaked it to regenerate one health per second
* Took out regenerateHealth() under request from Michael
* Added and tested rotatingTentacles
* Gave player more room to dodge in dance phase, made the spray bullets smaller, the outer bullets bigger, fire faster.
* The claustrophobic phase was created. Outer bullets shoot in a fence-like formation. Inner bullets do tons of damage
* Made outer ring smaller for claustrophobic phase
* Adjusted inner no-bullet ring size.
* Added telescope shooting methods
* Made stationary shooter shoot with telescope
* Made stationary shooter shoot with a stronger omni-directional telescope shot
* Fixed bug where continue game would have the same effect as start game
* Made firstBoss tentacles have more damage
* Tweaked setHealth() player method  to edit the maxHealth as well
* Made chaser chase the player unconditionally

June 3rd 2019:
=======================================================================================
Michael Zhang:
* Updated the color of enemy and allied bullets
* Added die() method to all enemies 
* Made enemies able to take damage from bullets with a takeDamage() method
* Made bullets fire semi-automatically every 100 ticks
* Update bulles with multiple shooting methods, single shot, semi-auto, and full-auto

Derek Lao:
* Updated chaser enemy to be a circle shape, not a triangle shape
* Added spreadShooting, there is a bug that does not let the bullets fire the full scope.
* Fixed by making the angle difference equal to 2pi divided by (number of bullets minus 1)
* Added singleShoot, circleShoot, and spreadShoot shell methods for monster shooting
* Added randomShoot(), implemented it in randomAimShoot(), circleRandomAimShoot(), and spreadRandomAimShoot()
* Figured out the nature of NaN for theta when it is impossible for the bullet to lead the player: it's in the discriminant of my first calculation in the method, the calculation of monsterToPlayerVelocity
* Decided that leadShoot() would be more realistic if the monster shot parallel to player movement if it were impossible for the bullet to lead and hit the player
* Reverted to previous leadShoot() case where the monster would just simply shoot at the player if it were impossible for the monster bullet to hit the player


June 2nd 2019:
=======================================================================================
Michael Zhang:
* Fixed a bug that didn't allow collisions to deal damage if the enemy was too close to the player
* Used the distance formula to now calculate collisions
* Integrate death screen with player death

Derek Lao:
* Using law of cosines, calculated the magnitude of the vector difference of bullet velocity and player velocity by using the angle between the player velocity and the displacement velocity between the player and the bullet. Then using law of cosines, calculated the angle between the bulletplayer velocity difference vector, and the bullet velocity vector. Then fire the bullet. Took me an hour to code, seems to only work when player travels clockwise.
* It seems when the player travels counterclockwise, the angle of leading needs to be negative. Added boolean check for player traveling counterclockwise, and if that boolean is fulfilled, the bullet will lead in the opposite angle direction.
* Sometimes that boolean would fail. Added a failproof boolean by using angles to check for player moving counterclockwise
* Keybound gameMenu to space bar
* Added option to return to main menu after person has died
* Added option to continue game or start new game from main menu
* Added energy text to gameMenu, removed option to return to main menu from gameMenu
* Added gamePaused, press p to pause game, press p to unpause or click the button to unpause, and added option to return to main menu from pause screen
* Fixed typo in howToScreen
* For leadPlayer() in monster, fixed edge case where the monster would lead opposite the player's movement if the playerToMonster heading were the opposite sign of predictedPlayerToMonster heading and the player's x coordinate were less than the monster's x coordinate

June 1st 2019:
=======================================================================================
Michael Zhang:
* Did nothing, had SAT

Derek Lao:
* Completed main menu
* Added lore story for fun, added option to click on it and also return to main menu.
* Proofread and fixed some grammar mistakes in lore
* Added option to return to mainMenu from gameMenu
* Fixed null pointer exceptions in mainMenu by replacing if statements to else-if statements
* Remade makeGrid() method to display lines, deleted original makeGrid.

May 31st 2019:
=======================================================================================
Michael Zhang:
* Added bullet collision, bullets now die on collision with player
* Made bullets do damage to player, tested it, it works.

Derek Lao:
* Took out redundant code in detectPlayer()
* Added preliminary code for mainMenu

May 30th 2019:
=======================================================================================
Michael Zhang:
* Added a death screen for when the enemy dies
* Updated player's health to decrease with bullet damage

Derek Lao:
* Scrapped vector method, brought back slopes method because that was much closer to the final product
* Implemented POSITIVE_INFINITY in calculations
* Got circlePlayerClockwise() to work by considering all cases of monster relation to player where a direction flip in the necessary vector was necessary. Cases like when the monster is above the player and is to the left of the player more than a radius amount, less than a radius amount, to the right of the player less than a radius amount, and more than a radius amount, and all of those conditions for when the monster is below the player as well.
* Successfully implemented circlePlayerCounterClockwise() by switching calls to slope1 to slope2 and vice versa from circlePlayerClockwise(). Tested to work.
* Created key binding to open gameMenu during game by holding down m.
* Gave gameMenu transparency.
* Made text nontransparent, made it green, and displays health in the gameMenu
* Implemented changing size for text
* Added font for the gameMenu text
* Added health bar in gameMenu
* Added text for health, armor, strength, speed
* Changed colors of each text
* Added stroke for gameMenu, changed background to white
* Added mainMenu to have a box to click to start the game, it works.
* Fixed bug where enemy would not stop shooting if it were out of the player's detection range

May 29th 2019:
=======================================================================================
Michael Zhang:
* Made the player movement much much smoother
* Started working on a new type of shooting that is smoother and faster

Derek Lao:
* Created realAngleDifference() method to calculate angle difference between vectors with a sign
* Created a vectorTangentLines() method to find the two tangent vectors
* Scrapped original slopes method, and used vector method to make monster do what I want it to do
* Failed, continue to work on it

May 28th 2019:
=======================================================================================
Michael Zhang:
* Updated the background colors and door colors
* Updated the speeds of the player and bullets to make them up to par with enemies
* Added a dodging mechanic that uses a new stat, energy, which replenishes over time
* Added a game over screen for when the player dies
* Started working on doing damage and bullet collision with enemies

Derek Lao
* Unsuccessfully implemented orbit movement with slopes. Going to try a different approach, involving arctangents.

May 27th 2019:
=======================================================================================
Michael Zhang:
* Added doors to rooms for the characters to progress through rooms/levels
* Helped Derek with calculations for the circler enemy

Derek Lao:
* Created method that takes 3 paramters: x coordinate of external point, y coordinate of external point, and radius of circle, to calcualte the two slopes of an external point to a circle centered at the origin
* Something wrong with the circling movement, such that at the start of the program the circler was being deleted if I moved my player directly left or right of the circler. Must find source of this bug, and fix later.
* Also, the circler circles correctly clockwise forthe top half of the circle. Other than that, it fails to circle. Must fix later.

May 26th 2019:
=======================================================================================
Michael Zhang:
* Started work on room generation and progressing through levels

Derek Lao:
* Calculated two slopes of the tangent lines of an external point to a circle centered at the origin

May 25th 2019:
=======================================================================================
Michael Zhang:
* Finished implementing bullets using PVectors, still need to make it smoother related to the framerate
* Gun does not shoot smoothly yet, but bullets are fixed

Derek Lao:
* Added code to display from an ArrayList<Entity> called "thingsToDisplay", does not quite work yet
* Added movement code for chaser, to chase player unconditionally up until it gets too close
* Added movement code for coward, where it would only run away when player gets too close, but otherwise it just wanders

May 24th 2019:
=======================================================================================
Michael Zhang:
* Did not work on project, studied for an AP Exam

Derek Lao:
* Added inRange(float, float) method
* Added code to make monster chase player at a certain range, but run away at another range, but the monster seems to chase the player at twice the speed than its regular movement speed, without me coding that in. Tested runFromPlayer() and followPlayer() to separately work though.
* Problem was fixed by use of else if statements... Not sure why though
* Fixed problem where when monster is running away from player, it would sometimes step out of the arena
* Implemented code to keep the player from stepping out of the arena

May 23rd 2019:
=======================================================================================
Michael Zhang:
* Did not work on project, studied for an AP Exam

Derek Lao:
* Completed vector usage for player and monster movement up until this point
* Wrote and successfully tested followPlayer
* Wrote and successfully tested monster to wander, and when detects player in vicinity, it will follow the player

May 22nd 2019:
========================================================================================
Michael Zhang:
* Updated bullet movement more, not quite successful yet
* Bullets still dependent on slope, xDirection and yDirection not scaled
* Bullets shoot opposite of the mouse direction when mouse is on the left of the character

Derek Lao:
* Successfully made jitter movement work for monster
* Added code for wall bouncing
* Implemented vectors, remade monster and player movement partially using the vectors
* Added separate experimental directories for Derek and Michael, and left a working version in separate folder.
* Bullet movement not working with vectors, awaiting fix and vector implementation

May 21st 2019:
========================================================================================
Derek Lao:
* Added monster class and implemented Alive methods

May 20th 2019:
========================================================================================
Michael Zhang:
* Made the grid actually draw per draw() call but putting the makeGrid() call in draw()
* Recreated Alive and Bullet interfaces
* Updated bullet movement, does not quite work

Derek Lao:
* Tried making a copy of the ball  and displaying it, did not work
* Tried putting the ball in an array list with a regular for loop of one increment, did not work
* Tried putting the ball in an array list with a for-each loop, did not work
* Checked back to Rock_Ball project, realized that there was a background() call per draw()
* Added background in draw() so the ball would refresh per move, so it actually moves instead of drawing a trail

May 19th 2019:
===========================================================================================
Michael Zhang:
* Added display method for the Entity class, detect method shell.
* Attempted to fix move method in player and was eventually fixed by Derek
* Fixed makeGrid() code to make grid
* Added move code for player, and created instance of player for usage

Derek Lao:
* Fixed problematic movement code for player by making up down left right booleans, and making move reference those booleans rather than reference the key calls
* Fixed a bug that made it so that the player shape does not move by putting the move() call in draw() instead of setup()

May 18th 2019:
===========================================================================================
Derek Lao:
* Added WASD key binding in player class, have not tested

May 17th 2019:
===========================================================================================
Michael Zhang:
* Added player class, updated setup method, added player class
