//Player player = new Player(width/2, height/2, 100, 10);
ArrayList<Room> rooms;

class Room{
  Integer number = 1;
  //ArrayList<Monster> enemies;
  //loot
}  

class Entity {
  Integer x;
  Integer y;
  PImage model;

  Entity(){
  }

  Entity(Integer x, Integer y) {
    this.x = x;
    this.y = y;
  }

  Integer getX() {
    return x;
  }

  Integer getY() {
    return y;
  }

  void setX(Integer input) {
    x = input;
  }
  
  void setY(Integer input) {
    y = input;
  }

  void display() {
  }
}

interface Alive {
  Integer getHealth();
  Integer getStrength();
  void setHealth(Integer newhealth);
  void setStrength(Integer newstrength);
}


class Player extends Entity implements Alive {
  Integer health;
  Integer strength;
  Integer speed;
  boolean up,down,left,right;
  
  /*Player(Integer newx, Integer newy, Integer h, Integer s){
    health = h;
    strength = s;
    super(newx,newy);
  }*/
  
  Integer getHealth() {
    return 1;
  }
  Integer getStrength() {
    return 1;
  }
  Integer getSpeed() }
    return 1;
  }
  void setHealth(Integer newhealth) {
  }
  void setStrength(Integer newstrength) {
  }
  void keyPressed(){
    
  }
  void keyReleased(){
  }
  void move() {
    float diagonalFactor = Math.sqrt(1 / ((Math.pow(k,2)) + 1));
    while(keyPressed)
    {
      if (key == 'w')
      {
        y -= speed;
      }
      if (key == 's')
      {
        y += speed;
      }
      if (key == 'a')
      {
        x += speed;
      }
      if (key == 'd')
      {
        x -= speed;
      }
    }
    
  }
}

void makeGrid(){
  for(int i = 0; i < width/10; i++){
    for (int c = 0; c < height/10; c++){
      noFill();
      stroke(0);
      rect(i * 10, c * 10, 10, 10);
    }
  }
}

void setup() {
  size(1000,700);
  makeGrid();
}
void draw() {
}
