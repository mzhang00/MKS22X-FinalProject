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
  Integer speed;
  boolean up, down, left, right;
  PShape model;

  Player(Float newx, Float newy, Integer h, Integer str, Integer spd) {
    super(newx, newy);    
    health = h;
    strength = str;
    speed = spd; 
    
  }
   void display(){
    rectMode(CENTER);
    model = createShape(RECT, x, y, 10, 10);
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
  
  void move() {
    //Float diagonalFactor = Math.sqrt(1 / ((Math.pow(k,2)) + 1));
    //System.out.println(int(left) + " " + int(right));
    Float diagonalFactor = new Float(Math.sqrt(1 / ((Math.pow(1, 2)) + 1)));
    boolean diagonalMoving = up && left || up && right || down && left || down && right;
    if (diagonalMoving)
    {
      x += float(speed) * diagonalFactor * (float((int(right) - int(left))));
      y += float(speed) * diagonalFactor * (float((int(down) - int(up))));
    } else
    {
      x += float(speed) * float(int(right) - int(left));
      y += float(speed) * float(int(down) - int(up));
    }
  }
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

Player player = new Player(500.0, 350.0, 10, 10, 10);

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

void setup() {
  size(1000, 700);
  makeGrid();
  System.out.println(width/2);
  System.out.println(player.getX());
  //player.display();
}

void draw() {
  //System.out.println(player.getX());
  background(255);
  makeGrid();
  player.display();
  player.move();
}
