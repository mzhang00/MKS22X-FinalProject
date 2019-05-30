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

boolean mainMenu, gameMenu, howToScreen;//to be implemented later
boolean gameIsRunning = true;
Float mousex;
Float mousey;
ArrayList<myBullet> bullets = new ArrayList<myBullet>(); 
ArrayList<Entity> thingsToDisplay = new ArrayList<Entity>();
ArrayList<Entity> thingsToMove = new ArrayList<Entity>();
Player player = new Player(500.0, 350.0, 5, 5, 3);//Player(Float newx, Float newy, Integer h, Integer str, Integer spd)
Monster monster = new Monster(500.0, 350.0, 5, 5, 1, player);//Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
Chaser chaser = new Chaser(500.0, 350.0, 5, 5, 1, player);//Chaser(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)
Coward coward = new Coward(500.0, 350.0, 5, 5, 1, player);
Circler circler = new Circler(500.0, 350.0, 5, 5, 1, player);

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
  frameRate(70);
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
}

//DRAW
void draw() {
  System.out.println(frameRate);
  //System.out.println(millis());
  //System.out.println(bullets);
  //System.out.println(mousex + " " + mousey);
  background(255);
  makeGrid();
  for (Entity e : thingsToDisplay)
  {
    e.display();
  }
  for (Entity e : thingsToMove)
  {
    e.move();
  }

  player.shoot();
  //monster.shoot();

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
    fill(0, 128);
    rectMode(CORNER);
    rect(250, 175, 500, 350, 25);
    String healthText = "Health: " + player.getHealth();
    //textSize(14);
    fill(0, 255, 0);   
    text(healthText, 300, 225, 100, 15);//smallest size is 15 for 1 line, 29 for 2 lines, 43 for 2 lines
    //text("hi", 300, 225);
  }
}
