class myBullet extends Entity {
  Integer strength;
  Float speed;

  myBullet(Integer s, Entity origin, Float targetx, Float targety, Float sp) {
    super(origin.getX(), origin.getY());
    strength = s;
    speed = sp;
    location.set(origin.getX(), origin.getY());
    velocity.set(targetx - origin.getX(), targety - origin.getY());
    velocity.setMag(speed);
  }

  void display() {
    model = createShape(ELLIPSE, location.x, location.y, 3, 3);
    model.setFill(color(0, 0, 0));
    shape(model);
  }

  void move() {
    location.add(velocity);
  }

  boolean die() {
    if (location.x <= 0 || location.x >= 1000 || location.y <= 0 || location.y >= 700) {
      bullets.remove(this);
      return true;
    }
    return false;
  }
}
