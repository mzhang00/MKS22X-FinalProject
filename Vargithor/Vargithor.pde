//Player player = new Player(width/2, height/2, 100, 10);
//ArrayList<Room> rooms;

class Room {
  Integer number = 1;
  //ArrayList<Monster> enemies;
  //loot
}  

class Entity {
  Float x;
  Float y;
  //PImage model;

  Entity(Float x, Float y) {
    this.x = x;
    this.y = y;
  }

  Float getX() {
    return x;
  }

  Float getY() {
    return y;
  }

  void setX(Float input) {
    x = input;
  }

  void setY(Float input) {
    y = input;
  }

  void display() {
    ellipse(x, y, 10, 10);
  }

  void detect(Entity other) {
    if (other.getX() == this.getX() && other.getY() == this.getY()) {
      //
    }
  }
}


class Player extends Entity {
  Integer health;
  Integer strength;
  Integer speed = 10;
  boolean up, down, left, right;

  Player(Float newx, Float newy, Integer h, Integer s) {
    super(newx, newy);    
    health = h;
    strength = s;
  }

  void display() {
    rectMode(CENTER);
    fill(0, 255, 0);
    rect(x, y, 10, 10);
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
  void keyPressed() {
    switch(key)
    {
    case 'w' : 
      up = true;
    case 's' : 
      down = true;
    case 'a' : 
      left = true;
    case 'd' : 
      right = true;
    }
  }
  void keyReleased() {
    switch(key)
    {
    case 'w' : 
      up = false;
    case 's' : 
      down = false;
    case 'a' : 
      left = false;
    case 'd' : 
      right = false;
    }
  }
  void move() {
    //Float diagonalFactor = Math.sqrt(1 / ((Math.pow(k,2)) + 1));
    Float diagonalFactor = new Float(Math.sqrt(1 / ((Math.pow(1, 2)) + 1)));
    boolean diagonalMoving = up && left || up && right || down && left || down && right;
    if (diagonalMoving)
    {
      x += float(speed) * diagonalFactor * (float((int(left) + int(right))));
      y += float(speed) * diagonalFactor * (float((int(up) + int(down))));
    } else
    {
      x += float(speed) * float(int(left) + int(right));
      y += float(speed) * float(int(up) + int(down));
    }
  }
}

void makeGrid() {
  for (int i = 0; i < width/10; i++) {
    for (int c = 0; c < height/10; c++) {
      if (i == 0 || i == width/10 - 1 || c * 10 == 0 || c== height/10 - 1) {
        fill(101, 67, 33);
        stroke(0);
        rect(i * 10, c * 10, 10, 10);
      } else {
        noFill();
        stroke(0);
        rect(i * 10, c * 10, 10, 10);
      }
    }
  }
}

Player player = new Player(500.0, 350.0, 10, 10);

void setup() {
  size(1000, 700);
  makeGrid();
  System.out.println(width/2);
  System.out.println(player.getX());
  player.display();
}

void draw() {
  //System.out.println(player.getX());
  player.move();
}
