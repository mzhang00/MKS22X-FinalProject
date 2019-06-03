class myBullet extends Entity {
  Integer strength;
  Float speed, originalx, originaly;
  color bulletColor;
  String type = "enemy"; 
  int lifetime = 0;

  myBullet(Integer s, Entity origin, Float targetx, Float targety, Float sp) {
    super(origin.getX(), origin.getY());
    strength = s;
    speed = sp;
    originalx = origin.getX();
    originaly = origin.getY();
    location.set(origin.getX(), origin.getY());
    velocity.set(targetx - origin.getX(), targety - origin.getY());
    velocity.setMag(speed);
    bulletColor = color(0, 0, 0);
  }

  myBullet(Integer s, Entity origin, Float targetx, Float targety, Float sp, color input) {
    super(origin.getX(), origin.getY());
    strength = s;
    speed = sp;
    originalx = origin.getX();
    originaly = origin.getY();
    location.set(origin.getX(), origin.getY());
    velocity.set(targetx - origin.getX(), targety - origin.getY());
    velocity.setMag(speed);
    bulletColor = input;
  }

  myBullet(Integer s, Entity origin, Float targetx, Float targety, Float sp, color input, String allied) {
    super(origin.getX(), origin.getY());
    strength = s;
    speed = sp;
    originalx = origin.getX();
    originaly = origin.getY();
    location.set(origin.getX(), origin.getY());
    velocity.set(targetx - origin.getX(), targety - origin.getY());
    velocity.setMag(speed);
    bulletColor = input;
    type = "allied";
  }

  void display() {
    model = createShape(ELLIPSE, location.x, location.y, 3, 3);
    model.setFill(bulletColor);
    shape(model);
    lifetime++;
  }

  void move() {
    location.add(velocity);
  }

  String getType() {
    return type;
  }

  Integer getStrength() {
    return strength;
  }

  Integer getLifetime() {
    return lifetime;
  }

  Float getSpeed() {
    return speed;
  }

  Float getOriginalX() {
    return originalx;
  }

  Float getOriginalY() {
    return originaly;
  }

  boolean die() {
    if (location.x <= 0 || location.x >= 1000 || location.y <= 0 || location.y >= 700) {
      bullets.remove(this);
      return true;
    }
    return false;
  }
}
