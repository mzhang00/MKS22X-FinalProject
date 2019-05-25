public class Thing{
  PShape model;
  PVector location;
  
  Thing(float x, float y)
  {
    location = new PVector(x, y);
  }
  
  float getX(){return location.x;}
  float getY(){return location.y;}
  
  
  
  void display() {
    PShape model;
    PVector point2 = new PVector(-2,1);
    PVector point3 = new PVector(2,1);
    point2.setMag(5);
    point3.setMag(5);
    model = createShape(TRIANGLE, getX(), getY() - 5, getX() + point2.x, getY() + point2.y, getX() + point3.x, getY() + point3.y);
    model.setFill(color(255, 0, 0));
    shape(model);
  }
}

Thing yes = new Thing(200, 200);

void setup() {
  size(400,400);
}

void draw() {
  background(255);
  yes.display();
}
