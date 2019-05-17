class Entity{
  Integer x;
  Integer y;
  PImage model;
  
  Entity(Integer x, Integer y){
    this.x = x;
    this.y = y;
  }
  
  Integer getX(){
    return x;
  }
  
  Integer getY(){
    return y;
  }
  
  void display(){}
}

interface Alive{
  Integer getHealth();
  Integer getStrength();
  void setHealth(Integer newhealth);
  void setStrength(Integer newstrength);
}

  

void setup(){}
void draw(){}