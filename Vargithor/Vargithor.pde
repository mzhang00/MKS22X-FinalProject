//TABLE OF CONTENTS
//MAKEGRID
//ENDSCREEN
//KEYPRESSED
//KEYRELEASED
//KEYTYPED
//MOUSECLICKED
//MOUSEDRAGGED
//MOUSEMOVED
//MOUSEPRESSED
//MOUSERELEASED
//SETUP
//DRAW

//Player player = new Player(width/2, height/2, 100, 10);//Player player = new Player(width/2, height/2, 100, 10);//Player player = new Player(width/2, height/2, 100, 10);//Player player = new Player(width/2, height/2, 100, 10);
//ArrayList<Room> rooms;

PFont gameMenuFont, mainMenuFont, loreScreenFont;
boolean gameMenu, howToScreen, endScreen, loreScreen;//to be implemented later
boolean gameIsRunning = false;
boolean mainMenu = true;
Float mousex;
Float mousey;
ArrayList<myBullet> bullets = new ArrayList<myBullet>(); 
ArrayList<Entity> thingsToDisplay = new ArrayList<Entity>();
ArrayList<Entity> thingsToMove = new ArrayList<Entity>();
ArrayList<Entity> thingsToShoot = new ArrayList<Entity>();
Player player = new Player(500.0, 350.0, 500, 5, 3);//Player(Float newx, Float newy, Integer h, Integer str, Integer spd)
Monster monster = new Monster(400.0, 350.0, 5, 5, 1, player);//Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
Chaser chaser = new Chaser(300.0, 350.0, 5, 5, 1, player);//Chaser(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
Coward coward = new Coward(200.0, 350.0, 5, 5, 1, player);
Circler circler = new Circler(100.0, 350.0, 5, 5, 1, player);

interface Alive {
  Integer getHealth();
  Integer getStrength();
  Integer getSpeed();

  void setHealth(Integer newhealth);
  void setStrength(Integer newstrength);
  void setSpeed(Integer newspeed);
}

//MAKEGRID
void makeGrid() {
  rectMode(CORNER);
  for (int i = 0; i < width/10; i++) {
    for (int c = 0; c < height/10; c++) {
      if (i == 0 || i == width/10 - 1 || c * 10 == 0 || c== height/10 - 1) {
        if (c >= 33 && c <= 36 || i >= 47 && i <= 52) {
          stroke(200);
          noFill();
        } else {
          noStroke();
          fill(0, 0, 0);
        }
        rect(i * 10, c * 10, 10, 10);
      } else {
        noFill();
        stroke(200);
        rect(i * 10, c * 10, 10, 10);
      }
    }
  }
}

//ENDSCREEN
void endScreen() { 
  thingsToDisplay.clear();
  thingsToMove.clear();
  background(0); 
  fill(255);
  text("You Died!", 500, 350);
}

//KEYPRESSED
void keyPressed() {
  if (gameIsRunning)
  {
    switch(key)
    {
    case 'v' :
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
    case 'm' :
      gameMenu = true;
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
    case 'v' :
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
    case 'm' :
      gameMenu = false;
      break;
    }
  }
}

//KEYTYPED
void keyTyped() {
}

//MOUSECLICKED
void mouseClicked() {
  mousex = (float) mouseX;
  mousey = (float) mouseY;
}

//MOUSEDRAGGED
void mouseDragged() {
}

//MOUSEMOVED
void mouseMoved() {
}

////MOUSEPRESSED
//void mousePressed() {
// mousex = (float) mouseX;
// mousey = (float) mouseY;
// }
// void mouseDragged() {
// mousex = (float) mouseX;
// mousey = (float) mouseY;
//}

//MOUSERELEASED
void mouseReleased() {
  mousex = null;
  mousey = null;
}

//SETUP
void setup() {
  size(1000, 700);
  makeGrid();
  frameRate(100);
  //System.out.println(width/2);
  //System.out.println(player.getX());
  //player.display();
  thingsToDisplay.add(player);
  thingsToDisplay.add(monster);
  thingsToDisplay.add(chaser);
  thingsToDisplay.add(coward);
  thingsToDisplay.add(circler);
  thingsToMove.add(player);
  thingsToMove.add(monster);
  thingsToMove.add(chaser);
  thingsToMove.add(coward);
  thingsToMove.add(circler);
  thingsToShoot.add(player);
  thingsToShoot.add(circler);
  
  gameMenuFont = createFont("GROBOLD.ttf", 30);
  mainMenuFont = createFont("GROBOLD.ttf", 20);
  loreScreenFont = createFont("atwriter.ttf", 12);
}

//DRAW
void draw() {
  System.out.println(frameRate);
  //System.out.println(millis());
  background(255);
  if(gameIsRunning)
  {
    makeGrid();
    for (Entity e : thingsToDisplay)
    {
      e.display();
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
    
    if (gameMenu)
    {
      fill(255, 100);
      stroke(0);
      rectMode(CORNER);
      rect(250, 175, 500, 350, 25);
      textFont(gameMenuFont);
      
      textAlign(LEFT, TOP);
      String healthText;
      if(player.getHealth() > 0)
        healthText = "Health: " + player.getHealth();
      else
        healthText = "Health: 0";
      color healthTextColor = color(0, 255, 0);
      String strengthText = "Strength: " + player.getStrength();
      color strengthTextColor = color(0, 0, 255);
      String speedText = "Speed: " + player.getSpeed();
      color speedTextColor = color(0, 150, 150);
      String armorText = "Armor: " + player.getArmor();
      color armorTextColor = color(128);
      
      textSize(30);//12 is the smallest size to display on a height 15 textbox.
      fill(healthTextColor);   
      text(healthText, 300, 225, 500, 40);//smallest size is 15 for 1 line, 29 for 2 lines, 43 for 2 lines
      
      Float healthFraction = (float)player.getHealth() / (float)player.getMaxHealth();
      Float dividingLineDistance = 400.0 * (healthFraction);
      if(healthFraction > 0.3)
        fill(0, 255, 0);
      else if(healthFraction <= 0.3 && healthFraction > 0.1)
        fill(255, 150, 0);
      else if(healthFraction <= 0.1)
        fill(255, 0, 0);
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
    }
  }
  else if(mainMenu)
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
    text("Press here to start", 375, 175, 250, 100);
    
    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 300, 250, 100);
    fill(0, 0, 255);
    textFont(mainMenuFont);
    textAlign(CENTER, CENTER);
    text("Lore", 375, 300, 250, 100);
    
    fill(200);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 425, 250, 100);
    fill(0, 0, 255);
    textFont(mainMenuFont);
    textAlign(CENTER, CENTER);
    text("How-To", 375, 425, 250, 100);
    if(mousex != null && mousey != null)
    {
      if(mousex >= 375 && mousex <= 375 + 250 && mousey >= 175 && mousey <= 175 + 100)
      {
        mainMenu = false;
        gameIsRunning = true;
        mousex = null;
        mousey = null;
      }
      
      else if(mousex >= 375 && mousex <= 375 + 250 && mousey >= 300 && mousey <= 300 + 100)
      {
        mainMenu = false;
        loreScreen = true;
        mousex = null;
        mousey = null;
      }
      
      else if(mousex >= 375 && mousex <= 375 + 250 && mousey >= 425 && mousey <= 425 + 100)
      {
        mainMenu = false;
        howToScreen = true;
        mousex = null;
        mousey = null;
      }
    }
  }
  else if(loreScreen)
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
    text("Back", 375, 575, 250, 100);
    
    if(mousex != null && mousey != null)
    {
      if(mousex >= 375 && mousex <= 375 + 250 && mousey >= 575 && mousey <= 575 + 100)
      {
        mainMenu = true;
        loreScreen = false;
        mousex = null;
        mousey = null;
      }
    }
  }
  else if(howToScreen)
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
    "M - Open in-game menu" + "\n";
    text(instructions, 100, 100, 900, 525);
    
    
    fill(100);
    stroke(0);
    rectMode(CORNER);
    stroke(255, 0, 0);
    rect(375, 575, 250, 100);
    textFont(mainMenuFont);
    fill(0);
    textAlign(CENTER, CENTER);
    text("Back", 375, 575, 250, 100);
    
    if(mousex != null && mousey != null)
    {
      if(mousex >= 375 && mousex <= 375 + 250 && mousey >= 575 && mousey <= 575 + 100)
      {
        mainMenu = true;
        howToScreen = false;
        mousex = null;
        mousey = null;
      }
    }
  }
  else if(endScreen)
  {
    endScreen();
  }
}
