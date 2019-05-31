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

  void display() {
    ellipse(getX(), getY(), 10, 10);
  }

  void isTouching(Entity other) {
    if (other.getX() == this.getX() && other.getY() == this.getY()) {
      //
    }
  }

  void move() {
  }

  void shoot() {
  }
}
