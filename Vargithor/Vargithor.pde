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
  
  Integer getHealth() {
    return 1;
  }
  Integer getStrength() {
    return 1;
  }
  void setHealth(Integer newhealth) {
  }
  void setStrength(Integer newstrength) {
  }
}

void makeGrid(){
  for(int i = 0; i < width/10; i++){
    for (int c = 0; c < height/10; c++){
      fill(255);
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