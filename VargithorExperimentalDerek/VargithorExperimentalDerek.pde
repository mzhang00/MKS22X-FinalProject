//Player player = new Player(width/2, height/2, 100, 10);
//ArrayList<Room> rooms;

ArrayList<myBullet> bullets = new ArrayList<myBullet>(); 
Player player = new Player(500.0, 350.0, 5, 5, 5);//Player(Float newx, Float newy, Integer h, Integer str, Integer spd)
Monster monster = new Monster(500.0, 350.0, 5, 5, 1, player);//Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player player)

interface Alive {
  Integer getHealth();
  Integer getStrength();
  Integer getSpeed();

  void setHealth(Integer newhealth);
  void setStrength(Integer newstrength);
  void setSpeed(Integer newspeed);
}

class Room {
  Integer number = 1;
  //ArrayList<Monster> enemies;
  //loot
}  

class Entity {
  PVector location;
  PShape model;

  Entity(Float x, Float y) {
    location = new PVector(x, y);
  }

  Float getX() {
    return location.x;
  }

  Float getY() {
    return location.y;
  }

  void setX(Float input) {
    location.set(input, location.y);
  }

  void setY(Float input) {
    location.set(location.x, input);
  }

  void display() {
    ellipse(getX(), getY(), 10, 10);
  }

  void isTouching(Entity other) {
    if (other.getX() == this.getX() && other.getY() == this.getY()) {
      //
    }
  }
}


class myBullet extends Entity {
  Integer strength;
  Float xDirection;
  Float yDirection;
  myBullet(Integer s, Float thisx, Float thisy, Float newx, Float newy) {
    super(thisx, thisy);
    strength = s;
    xDirection = newx;
    yDirection = newy;
  }
  void display() {
    model = createShape(ELLIPSE, getX(), getY(), 3, 3);
    model.setFill(color(0, 0, 0));
    shape(model);
  }
  void move() {
    if (getX() != xDirection && getY() != yDirection) {
      location.set((getX() - xDirection)/500.0, (getY() - yDirection)/350.0);
    }
  }
  void die() {
    if (getX() <= 0 || getX() >= 1000 || getY() <= 0 || getY() >= 700) {
      bullets.remove(this);
    }
  }
}

class Player extends Entity implements Alive {
  Integer health, strength, speed;
  boolean up, down, left, right;
  PShape model;
  PVector velocity;

  Player(Float newx, Float newy, Integer h, Integer str, Integer spd) {
    super(newx, newy);    
    health = h;
    strength = str;
    speed = spd;

    do
    {
      velocity = new PVector(random(-5, 5), random(-5, 5));
    } 
    while (5 - Math.abs(getSpeed()) > 3 && 5 - Math.abs(getSpeed()) > 3);
  }
  void shoot() {
    if (mousex != null && mousey != null) {
      myBullet bullet = new myBullet(1, getX(), getY(), mousex, mousey);
      bullets.add(bullet);
    }
  }
  void display() {
    rectMode(CENTER);
    model = createShape(RECT, getX(), getY(), 10, 10);
    model.setFill(color(0, 255, 0));
    shape(model);
  }

  Integer getHealth() {
    return health;
  }
  Integer getStrength() {
    return strength;
  }
  Integer getSpeed() {
    return speed;
  }
  void setHealth(Integer newhealth) {
    health = newhealth;
  }

  void setStrength(Integer newstrength) {
    strength = newstrength;
  }

  void setSpeed(Integer newspeed) {
    speed = newspeed;
  }

  float getXSpeed() {
    return velocity.x;
  }
  float getYSpeed() {
    return velocity.y;
  }

  void move() {
    //Float diagonalFactor = Math.sqrt(1 / ((Math.pow(k,2)) + 1));
    //boolean diagonalMoving = up && left || up && right || down && left || down && right;
    
    velocity.set(float((int(right) - int(left))), float((int(down) - int(up))));
    velocity.setMag(float(getSpeed()));
    
    PVector holder = velocity;
    if(Math.abs(getX() + getXSpeed() - width/2) > (width/2 - 10))
      velocity.set(0, holder.y);
    if(Math.abs(getY() + getYSpeed() - height/2) > (height/2 - 10))
      velocity.set(holder.x, 0);
      
    location.add(velocity);
    velocity.set(holder);
  }
}



class Monster extends Entity implements Alive {
  Integer health, strength, speed;
  PShape model;
  PVector velocity;
  Player player;

  Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy);    
    health = h;
    strength = str;
    speed = spd;

    velocity = new PVector(random(-5, 5), random(-5, 5));
    generateRandomDirection();

    player = givenPlayer;
  }
  
  void display() {
    ellipseMode(CENTER);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 0));
    shape(model);
  }

  Integer getHealth() {
    return health;
  }
  Integer getStrength() {
    return strength;
  }
  Integer getSpeed() {
    return speed;
  }

  void setHealth(Integer newhealth) {
    health = newhealth;
  }
  void setStrength(Integer newstrength) {
    strength = newstrength;
  }
  void setSpeed(Integer newspeed) {
    speed = newspeed;
  }

  float getXSpeed() {
    return velocity.x;
  }
  float getYSpeed() {
    return velocity.y;
  }

  boolean inRange(float range) {
    //equation of circle around player is (x - player.getX()) ^ 2 + (y - getY()) ^ 2 = radius ^2;
    return inRange(0, range);
  }
  
  boolean inRange(float rangeMin, float rangeMax) {
    if (Math.pow(this.getX() - player.getX(), 2.0) + Math.pow(this.getY() - player.getY(), 2.0) < Math.pow(rangeMax,2) && 
      Math.pow(this.getX() - player.getX(), 2.0) + Math.pow(this.getY() - player.getY(), 2.0) >= Math.pow(rangeMin,2))
      return true;
    else
      return false;
  }
  
  void bounceWallRealistic() {
    if (Math.abs(getX() + getXSpeed() - width/2) > (width/2 - 10))
      velocity.set(getXSpeed() * -1, getYSpeed());
    if (Math.abs(getY() + getYSpeed() - height/2) > (height/2 - 10))
      velocity.set(getXSpeed(), getYSpeed() * -1);
  }
  void bounceWallRandom() {
    if ((Math.abs(getX() + getXSpeed() - width/2) > (width/2 - 10)) || 
      (Math.abs(getY() + getYSpeed() - height/2) > (height/2 - 10)))
    {
      do
      {
        velocity.set(random(-5, 5), random(-5, 5));
      } 
      while (5 - Math.abs(getXSpeed()) > 3 && 5 - Math.abs(getYSpeed()) > 3);
      //this loop ensures values from -5 to -2, and 2 to 5, but not small values 
      //for both x and y between -2 and 2.
    }
  }
  private void generateRandomDirection() {
    float angle = random(0, 360);
    velocity.rotate(angle);
    velocity.setMag(float(getSpeed()));
  }

  void move() {
    if(inRange(50.0, 100.0))
      followPlayer();
    else if(inRange(50.0))
      runFromPlayer();
    else
      wanderRegular();
    
    //if(inRange(50.0))
    //  runFromPlayer();
    //else
    //  followPlayer();
    
    //jitter();
    //straightLine();
    //wanderRegular();
    //wanderSlow();
    //followPlayer();
    //runFromPlayer();
  }

  void jitter() {
    //if (millis() % 1000 == 0)
    //if(frameCount % 60 == 0)
    //{
    //  generateRandomDirection();
    //}
    generateRandomDirection();
    bounceWallRealistic();
    location.add(velocity);
  }

  void straightLine() {
    bounceWallRealistic();
    location.add(velocity);
  }

  void wanderSlow() {
    //if (millis() % 1000 == 1)
    if (frameCount % 60 == 1)
    {
      generateRandomDirection();
      velocity.setMag(float(getSpeed())/2.0);
    }
    bounceWallRealistic();
    location.add(velocity);
    velocity.setMag(float(getSpeed()));
  }
  
  void wanderRegular() {
    if (frameCount % 60 == 1)
      generateRandomDirection();
    bounceWallRealistic();
    location.add(velocity);
  }

  void followPlayer() {
    velocity.set(player.getX() - this.getX(), player.getY() - this.getY());
    velocity.setMag(float(speed));
    
    bounceWallRealistic();
    location.add(velocity);
  }
  
  void runFromPlayer() {
    velocity.set(this.getX() - player.getX(), this.getY() - player.getY());
    velocity.setMag(float(speed));
    bounceWallRealistic();
    location.add(velocity);
  }
}

class Chaser extends Monster{
  Chaser(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }
  
  void display() {
    ellipseMode(CENTER);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 0));
    shape(model);
  }
  
  void move() {
    if(inRange(50.0, 100.0))
    {
      followPlayer();
    }
    else if(inRange(50.0))
    {
      runFromPlayer();
    }
    else
    {
      wanderRegular();
    }
  }
}
class Coward extends Monster{
  Coward(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }
  
  void display() {
    ellipseMode(CENTER);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 0));
    shape(model);
  }
  
  void move() {
    if(inRange(100.0))
    {
      runFromPlayer();
    }
    else
    {
      wanderRegular();
    }
  }
}
class Circler extends Monster{
  Circler(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }
  
  void display() {
    ellipseMode(CENTER);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 0));
    shape(model);
  }
  
  void move() {}
}

void makeGrid() {
  rectMode(CORNER);
  for (int i = 0; i < width/10; i++) {
    for (int c = 0; c < height/10; c++) {
      if (i == 0 || i == width/10 - 1 || c * 10 == 0 || c== height/10 - 1) {
        fill(101, 67, 33);
        noStroke();
        rect(i * 10, c * 10, 10, 10);
      } else {
        noFill();
        stroke(0);
        rect(i * 10, c * 10, 10, 10);
      }
    }
  }
}

void keyPressed() {
  switch(key)
  {
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
  }
}
void keyReleased() {
  switch(key)
  {
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
  }
}

Float mousex;
Float mousey;

void mouseClicked() {
  mousex = (float) mouseX;
  mousey = (float) mouseY;
}
/*
void mousePressed() {
 mousex = (float) mouseX;
 mousey = (float) mouseY;
 }
 void mouseDragged() {
 mousex = (float) mouseX;
 mousey = (float) mouseY;
 }*/

void mouseReleased() {
  mousex = null;
  mousey = null;
}


void setup() {
  size(1000, 700);
  makeGrid();
  frameRate(70);
  //System.out.println(width/2);
  //System.out.println(player.getX());
  //player.display();
}

void draw() {
  System.out.println(frameRate);
  //System.out.println(mousex + " " + mousey);
  background(255);
  makeGrid();
  player.display();
  monster.display();
  player.move();
  monster.move();
  player.shoot();
  //monster.shoot();
  for (myBullet bullet : bullets) {
    bullet.display(); 
    bullet.move();
  }
  mousex = null;
  mousey = null;
}
