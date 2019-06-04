class myBullet extends Entity {
  Integer strength, size;
  Integer lifetime = 1000000000;
  Integer lifeSpan;
  Float speed, originalx, originaly;
  color bulletColor;
  String type = "enemy"; 

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
    size = 3;
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
    size = 3;
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
    size = 3;
  }

  void display() {
    model = createShape(ELLIPSE, location.x, location.y, size, size);
    if (type.equals("enemy")) {
      model.setStroke(color(255, 0, 0));
      bulletColor = color(139, 0, 0);
    } else {
      model.setStroke(color(0, 255, 0));
      bulletColor = color(0, 139, 0);
    }
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
  
  Integer getSize() {
    return size;
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
    if (lifetime >= lifeSpan){
      bullets.remove(this);
      return true;
    }
    return false;
  }
}
