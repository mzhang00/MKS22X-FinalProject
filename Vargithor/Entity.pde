class Entity {
  PVector location, velocity;
  PShape model;

  Entity(Float x, Float y) {
    location = new PVector(x, y);
    velocity = new PVector(1, 0);
  }

  Float getX() {
    return location.x;
  }

  Float getY() {
    return location.y;
  }

  Float getXSpeed() {
    return velocity.x;
  }

  Float getYSpeed() {
    return velocity.y;
  }

  void setX(Float input) {
    location.set(input, location.y);
  }

  void setY(Float input) {
    location.set(location.x, input);
  }

  void setXSpeed(Float input) {
    velocity.set(input, velocity.y);
  }

  void setYSpeed(Float input) {
    velocity.set(velocity.x, input);
  }

  Integer getHealth() {
    return 0;
  }
  
  Integer getID() {
    return 0;
  }

  void display() {
    ellipse(getX(), getY(), 10, 10);
  }

  void move() {
  }

  void shoot() {
  }
}
