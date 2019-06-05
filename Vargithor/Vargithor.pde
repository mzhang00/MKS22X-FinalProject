//MAKEGRID
//ENDSCREEN
//LOADGAME
//CLEARENTITIES
//KEYPRESSED
//KEYRELEASED
//KEYTYPED
//MOUSECLICKED
//MOUSEMOVED
//MOUSEPRESSED
//MOUSEDRAGGED
//MOUSERELEASED
//SETUP
//DRAW

//Player player = new Player(width/2, height/2, 100, 10);//Player player = new Player(width/2, height/2, 100, 10);//Player player = new Player(width/2, height/2, 100, 10);//Player player = new Player(width/2, height/2, 100, 10);
//ArrayList<Room> rooms;

PFont gameMenuFont, mainMenuFont, loreScreenFont;
boolean gameMenu, howToScreen, loreScreen, gamePaused;
boolean gameExists = false;
boolean gameIsRunning = false;
boolean mainMenu = true;
boolean gameOver = false;
boolean stopYet = true;
Float mousex;
Float mousey;
ArrayList<myBullet> bullets = new ArrayList<myBullet>(); 
ArrayList<Entity> thingsToDisplay = new ArrayList<Entity>();
ArrayList<Entity> thingsToMove = new ArrayList<Entity>();
ArrayList<Entity> thingsToShoot = new ArrayList<Entity>();
Player player;
Room room = new Room();
//Monster monster;
//Chaser chaser;
//Coward coward;
//Circler circler;
//StationaryShooter stationaryShooter;
//FirstBoss firstBoss;

//LOADGAME
void loadGame() {
  player = new Player(500.0, 350.0, 500, 1, 3);//Player(Float newx, Float newy, Integer h, Integer str, Integer spd)
  //monster = new Monster(400.0, 350.0, 5, 1, 1, player);//Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
  //chaser = new Chaser(300.0, 350.0, 5, 1, 1, player);//Chaser(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
  //coward = new Coward(200.0, 350.0, 5, 1, 1, player);//Coward(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
  //circler = new Circler(100.0, 350.0, 5, 1, 1, player);//Circler(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
  //stationaryShooter = new StationaryShooter(150.0, 350.0, 5, 1, 1, player);//StationaryShooter(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer)
  //firstBoss = new FirstBoss(450.0, 350.0, 100, 1, 1, player);

  thingsToDisplay.add(player);
  //thingsToDisplay.add(monster);
  //thingsToDisplay.add(chaser);
  //thingsToDisplay.add(coward);
  //thingsToDisplay.add(circler);
  //thingsToDisplay.add(stationaryShooter);
  //thingsToDisplay.add(firstBoss);

  thingsToMove.add(player);
  //thingsToMove.add(monster);
  //thingsToMove.add(chaser);
  //thingsToMove.add(coward);
  //thingsToMove.add(circler);
  //thingsToMove.add(stationaryShooter);
  //thingsToMove.add(firstBoss);

  thingsToShoot.add(player);
  //thingsToShoot.add(circler);
  //thingsToShoot.add(stationaryShooter);
  //thingsToShoot.add(firstBoss);
  room.createRoom();
}

interface Alive {
  Integer getHealth();
  Integer getStrength();
  Integer getSpeed();

  void setHealth(Integer newhealth);
  void setStrength(Integer newstrength);
  void setSpeed(Integer newspeed);
}

//MAKEGRID
void makeGrid() {//33 and 36 for vertical, 47 and 52 for horizontal
  stroke(200);
  for (int i = 0; i < width/10; i++) {
    line(i * 10, 0, i * 10, height);
  }
  for (int c = 0; c < height/10; c++) {
    line(0, c * 10, width, c * 10);
  }

  noStroke();
  fill(0);
  rectMode(CORNERS);
  rect(0, 0, 47 * 10, 10);
  rect(52 * 10, 0, width - 10, 10);
  rect(width - 10, 0, width, 33 * 10);
  rect(width - 10, 36 * 10, width, height);
  rect(52 * 10, height - 10, width - 10, height);
  rect(10, height - 10, 47 * 10, height);
  rect(0, 36 * 10, 10, height);
  rect(0, 10, 10, 33 * 10);
}

//ENDSCREEN
void endScreen() { 
  background(0); 
  fill(255);
  text("You Died!", 500, 350);

  fill(100);
  stroke(0);
  rectMode(CORNER);
  stroke(255, 0, 0);
  rect(375, 575, 250, 100);
  textFont(mainMenuFont);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  text("Return To Main Menu", 375, 575, 250, 100);

  if (mousex != null && mousey != null)
  {
    if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 575 && mousey <= 575 + 100)
    {
      mainMenu = true;
      gameIsRunning = false;
      gameOver = false;
      gameMenu = false;
      mousex = null;
      mousey = null;
    }
  }
}



//CLEARENTITIES
void clearEntities() {
  thingsToDisplay.clear();
  thingsToMove.clear();
  thingsToShoot.clear();
  bullets.clear();
}

//KEYPRESSED
void keyPressed() {
  if (gamePaused)
  {
    switch(key)
    {
    case 'p' :
      gamePaused = false;
      gameIsRunning = true;
      break;
    }
  } else if (gameIsRunning)
  {
    switch(key)
    {
    case 'r' :
      player.dodge = true;
      break;
    case 'w' : 
      player.up = true;
      break;
    case 's' : 
      player.down = true;
      break;
    case 'a' : 
      player.left = true;
      break;
    case 'd' : 
      player.right = true;
      break;
    case ' ' :
      gameMenu = true;
      break;
    case 'p' :
      gamePaused = true;
      gameIsRunning = false;
      gameMenu = false;
      player.dodge = false;
      player.up = false;
      player.down = false;
      player.left = false;
      player.right = false;
      break;
    }
  }
}

//KEYRELEASED
void keyReleased() {
  if (gameIsRunning)
  {
    switch(key)
    {
    case 'r' :
      player.dodge = false;
      break;
    case 'w' : 
      player.up = false;
      break;
    case 's' : 
      player.down = false;
      break;
    case 'a' : 
      player.left = false;
      break;
    case 'd' : 
      player.right = false;
      break;
    case ' ' :
      gameMenu = false;
      break;
    }
  }
}

//KEYTYPED
void keyTyped() {
}

//MOUSECLICKED
//void mouseClicked() {
//  mousex = (float) mouseX;
//  mousey = (float) mouseY;
//}

//MOUSEMOVED
void mouseMoved() {
}

////MOUSEPRESSED
void mousePressed() {
  mousex = (float) mouseX;
  mousey = (float) mouseY;
}

//MOUSEDRAGGED
void mouseDragged() {
  mousex = (float) mouseX;
  mousey = (float) mouseY;
}

//MOUSERELEASED
void mouseReleased() {
  mousex = null;
  mousey = null;
}

//SETUP
void setup() {
  size(1000, 700);
  frameRate(60);
  //System.out.println(width/2);
  //System.out.println(player.getX());
  //player.display();

  gameMenuFont = createFont("GROBOLD.ttf", 30);
  mainMenuFont = createFont("GROBOLD.ttf", 20);
  loreScreenFont = createFont("atwriter.ttf", 12);
}

//DRAW
void draw() {
  //System.out.println(frameRate);
  //System.out.println(millis());
  //System.out.println(thingsToDisplay);
  //System.out.println(thingsToMove);
  background(255);
  if (gameIsRunning)
  {
    makeGrid();
    for (int i = 0; i < thingsToDisplay.size(); i++) {
      Entity e = thingsToDisplay.get(i);
      if (e.getHealth() > 0) {
        e.display();
      } else {
        thingsToDisplay.remove(e);
        thingsToMove.remove(e);
        thingsToShoot.remove(e);
        i--;
      }
    }
    for (Entity e : thingsToMove)
    {
      e.move();
    }
    for (Entity e : thingsToShoot)
    {
      e.shoot();
    }

    for (int i = 0; i < bullets.size(); i++) {
      myBullet bullet = bullets.get(i);
      bullet.display(); 
      bullet.move();
      if (bullet.die()) {
        i--;
      }
    }

    for (int i = 0; i < thingsToDisplay.size(); i++) {
      if (thingsToDisplay.get(i).getID() == 1) {
        stopYet = false;
      } else {
      }
    }

    if (stopYet) {
      gameIsRunning = false;
      gameOver = true;
    }else{
      stopYet = !stopYet;
    }

    if (gameMenu)
    {
      fill(255, 100);
      stroke(0);
      rectMode(CORNER);
      rect(250, 175, 500, 360, 25);
      textFont(gameMenuFont);

      textAlign(LEFT, TOP);
      String healthText;
      healthText = "Health: " + player.getHealth();
      color healthTextColor = color(0, 255, 0);
      String strengthText = "Strength: " + player.getStrength();
      color strengthTextColor = color(0, 0, 255);
      String speedText = "Speed: " + player.getSpeed();
      color speedTextColor = color(0, 150, 150);
      String armorText = "Armor: " + player.getArmor();
      color armorTextColor = color(128);
      String energyText = "Energy: " + player.getEnergy();
      color energyTextColor = color(225, 225, 0);
      String roomText = "Room: " + room.getRoom();
      color roomTextColor = color(255, 0, 0);

      textSize(30);//12 is the smallest size to display on a height 15 textbox.
      fill(healthTextColor);   
      text(healthText, 300, 225, 500, 40);//smallest size is 15 for 1 line, 29 for 2 lines, 43 for 2 lines

      Float healthFraction = (float)player.getHealth() / (float)player.getMaxHealth();
      Float dividingLineDistance = 400.0 * (healthFraction);
      if (healthFraction > 0.3)
        fill(0, 255, 0);
      else if (healthFraction <= 0.3 && healthFraction > 0.1)
        fill(255, 150, 0);
      else if (healthFraction <= 0.1)
      {
        fill(255, 0, 0);
      }
      rect(300, 260, dividingLineDistance, 10);
      //player.setHealth(46);
      fill(0);
      rect(300 + dividingLineDistance, 260, 400.0 - dividingLineDistance, 10);

      fill(armorTextColor);
      text(armorText, 300, 285, 500, 40);

      fill(strengthTextColor);
      text(strengthText, 300, 330, 500, 40);

      fill(speedTextColor);
      text(speedText, 300, 375, 500, 40);

      fill(energyTextColor);
      text(energyText, 300, 420, 500, 40);

      fill(roomTextColor);
      text(roomText, 300, 465, 500, 40);
    }
  } else if (gameOver)
  {
    endScreen();
  } else if (gamePaused)
  {
    background(100, 100);
    fill(200);
    textFont(mainMenuFont);
    textAlign(CENTER);
    text("Game Paused", 375, 175, 250, 100);
    fill(220, 0, 0);
    text("Room: " + room.getRoom(), 375, 225, 250, 100);

    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 450, 250, 100);
    textFont(mainMenuFont);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Unpause (P)", 375, 450, 250, 100);

    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 575, 250, 100);
    textFont(mainMenuFont);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    text("Return To Main Menu", 375, 575, 250, 100);

    if (mousex != null && mousey != null)
    {
      if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 450 && mousey <= 450 + 100)
      {
        gameIsRunning = true;
        gamePaused = false;
        mousex = null;
        mousey = null;
      } else if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 575 && mousey <= 575 + 100)
      {
        mainMenu = true;
        gameIsRunning = false;
        gameMenu = false;
        gamePaused = false;
        mousex = null;
        mousey = null;
      }
    }
  } else if (mainMenu)
  {
    background(100);

    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 175, 250, 100);
    fill(0, 0, 255);
    textFont(mainMenuFont);
    textAlign(CENTER, CENTER);
    text("Start New Game", 375, 175, 250, 100);

    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 300, 250, 100);
    fill(0, 0, 255);
    textFont(mainMenuFont);
    textAlign(CENTER, CENTER);
    text("Continue Game", 375, 300, 250, 100);

    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 425, 250, 100);
    fill(0, 0, 255);
    textFont(mainMenuFont);
    textAlign(CENTER, CENTER);
    text("Lore", 375, 425, 250, 100);

    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 550, 250, 100);
    fill(0, 0, 255);
    textFont(mainMenuFont);
    textAlign(CENTER, CENTER);
    text("How-To", 375, 550, 250, 100);
    if (mousex != null && mousey != null)
    {
      if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 175 && mousey <= 175 + 100)
      {
        mainMenu = false;
        gameIsRunning = true;
        gameOver = false;
        gameExists = true;
        clearEntities();
        room.resetRoom();
        loadGame();
        mousex = null;
        mousey = null;
      } else if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 300 && mousey <= 300 + 100)
      {
        if (gameExists)
        {
          mainMenu = false;
          gameIsRunning = true;
        } else
        {
          mainMenu = false;
          gameIsRunning = true;
          gameOver = false;
          gameExists = true;
          clearEntities();
          loadGame();
          room.resetRoom();
        }
        mousex = null;
        mousey = null;
      } else if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 425 && mousey <= 425 + 100)
      {
        mainMenu = false;
        loreScreen = true;
        mousex = null;
        mousey = null;
      } else if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 550 && mousey <= 550 + 100)
      {
        mainMenu = false;
        howToScreen = true;
        mousex = null;
        mousey = null;
      }
    }
  } else if (loreScreen)
  {
    background(200);
    fill(0);
    textFont(loreScreenFont);
    textAlign(CENTER, CENTER);
    String loreText = "A man named Jack lived a very troubled life. " + 
      "There was a mysterious plague that took over his city, and it killed his wife and his only two children. " + 
      "He took up drinking very hard, and asked every day that the plague would take his life as well. " + 
      "One night, he thought his request to die has been answered, when he opened the door of his home, " + 
      "and a blinding white light shone from within. " + 
      "A dark, black hand reached out, and a ghostly voice cried \"Vargithor!\" " + 
      "Before Jack could figure out what was going on, the hand grabbed him and forcefully pulled him into the house. " + 
      "\"Vargithor... Vargithor...\" could be heard all around him. " + 
      "He screamed a blood-curdling scream, which made the voice louder and more frequent. " + 
      "\"Vargithor! Vargithor!\", it chanted. " + 
      "Jack's body was compressing into a flat circle. " + 
      "His skin seemed to rot, for, green patches grew over it, eventually covering it all. " + 
      "He did not know what was going on, but thought this was meant to be. " + 
      "He decided that from that moment on, he would be Vargithor. " + 
      "He looked around, monsters in the form of triangles and other circles roamed around. " + 
      "Some, moved towards him. Expressionless but determined, those monsters fired at Vargithor. " + 
      "Not knowing what to do, Vargithor panicked. He noticed a gun inside his pocket. " + 
      "He pulled it out and shot at the monster multiple times, until it died. " + 
      "He found he could still move around, and avoid the monster's bullets. More monsters appeared on the horizon. " + 
      "He did not know where he was, his purpose for being there, but he can not think about it now... He must defend himself...";
    text(loreText, 250, 100, 500, 500);

    fill(100);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 575, 250, 100);
    textFont(mainMenuFont);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Return To Main Menu", 375, 575, 250, 100);

    if (mousex != null && mousey != null)
    {
      if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 575 && mousey <= 575 + 100)
      {
        mainMenu = true;
        loreScreen = false;
        mousex = null;
        mousey = null;
      }
    }
  } else if (howToScreen)
  {
    background(200);
    fill(0);
    textFont(mainMenuFont);
    rectMode(CORNERS);
    fill(0);
    textAlign(CENTER, CENTER);
    text("How-To", 50, 50, 1000, 100);
    textAlign(LEFT, CENTER);
    String instructions = 
      "W - Up" + "\n" + 
      "A - Left" + "\n" + 
      "S - Down" + "\n" + 
      "D - Right" + "\n" +  
      "R - Dash forward" + "\n" +
      "P - Pause game" + "\n" +
      "SPACE - Open in-game menu" + "\n";

    text(instructions, 100, 100, 900, 525);

    fill(100);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 575, 250, 100);
    textFont(mainMenuFont);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Return To Main Menu", 375, 575, 250, 100);

    if (mousex != null && mousey != null)
    {
      if (mousex >= 375 && mousex <= 375 + 250 && mousey >= 575 && mousey <= 575 + 100)
      {
        mainMenu = true;
        howToScreen = false;
        mousex = null;
        mousey = null;
      }
    }
  }
}
