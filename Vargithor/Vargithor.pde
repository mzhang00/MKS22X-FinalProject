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



void setup() {
}
void draw() {
}