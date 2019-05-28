# MKS22X-FinalProject
AP CS Final Project
Development log:

May 27th 2019:
=======================================================================================
Michael Zhang:
* Added doors to rooms for the characters to progress through rooms/levels

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
