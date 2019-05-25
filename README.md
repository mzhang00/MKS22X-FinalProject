# MKS22X-FinalProject
AP CS Final Project
Development log:

May 25th 2019:
=======================================================================================
Derek Lao:
* Added code to display from an ArrayList<Entity> called "thingsToDisplay", does not quite work yet
  
May 24th 2019:
=======================================================================================
Derek Lao:
* Added inRange(float, float) method
* Added code to make monster chase player at a certain range, but run away at another range, but the monster seems to chase the player at twice the speed than its regular movement speed, without me coding that in. Tested runFromPlayer() and followPlayer() to separately work though. 
* Problem was fixed by use of else if statements... Not sure why though
* Fixed problem where when monster is running away from player, it would sometimes step out of the arena
* Implemented code to keep the player from stepping out of the arena

May 23rd 2019:
=======================================================================================
Derek Lao: 
* Completed vector usage for player and monster movement up until this point.
* Wrote and successfully tested followPlayer
* Wrote and successfully tested monster to wander, and when detects player in vicinity, it will follow the player.

May 22nd 2019:
========================================================================================
Michael Zhang:
* Updated bullet movement more, not quite successful yet.
* Bullets still dependent on slope, xDirection and yDirection not scaled
* Bullets shoot opposite of the mouse direction when mouse is on the left of the character

Derek Lao:
* Successfully made jitter movement work for monster.
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
* Tried making a copy of the ball  and displaying it, did not work.
* Tried putting the ball in an array list with a regular for loop of one increment, did not work.
* Tried putting the ball in an array list with a for-each loop, did not work
* Checked back to Rock_Ball project, realized that there was a background() call per draw()
* Added background in draw() so the ball would refresh per move, so it actually moves instead of drawing a trail.

May 19th 2019:
===========================================================================================
Michael Zhang: 
* Added display method for the Entity class, detect method shell. 
* Attempted to fix move method in player and was eventually fixed by Derek.
* Fixed makeGrid() code to make grid
* Added move code for player, and created instance of player for usage

Derek Lao: 
* Fixed problematic movement code for player by making up down left right booleans, and making move reference those booleans rather than reference the key calls.
* Fixed a bug that made it so that the player shape does not move by putting the move() call in draw() instead of setup()

May 18th 2019:
===========================================================================================
Derek Lao: 
* Added WASD key binding in player class, have not tested

May 17th 2019:
===========================================================================================
Michael Zhang: 
* Added player class, updated setup method, added player class
