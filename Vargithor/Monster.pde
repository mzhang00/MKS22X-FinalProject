//MONSTER
class Monster extends Entity implements Alive {
  Integer health, strength, speed;
  PShape model;
  Player player;

  Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy);    
    health = h;
    strength = str;
    speed = spd;
    generateRandomDirection();
    player = givenPlayer;
  }

  void display() {
    ellipseMode(CENTER);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 0));
    shape(model);
  }

  Integer getHealth() {
    return health;
  }

  Integer getStrength() {
    return strength;
  }

  Integer getSpeed() {
    return speed;
  }

  void setHealth(Integer newhealth) {
    health = newhealth;
  }

  void setStrength(Integer newstrength) {
    strength = newstrength;
  }

  void setSpeed(Integer newspeed) {
    speed = newspeed;
  }

  boolean inRange(float range) {
    //equation of circle around player is (x - player.getX()) ^ 2 + (y - getY()) ^ 2 = radius ^2;
    return inRange(0, range);
  }

  boolean inRange(float rangeMin, float rangeMax) {
    if (Math.pow(this.getX() - player.getX(), 2.0) + Math.pow(this.getY() - player.getY(), 2.0) < Math.pow(rangeMax, 2) && 
      Math.pow(this.getX() - player.getX(), 2.0) + Math.pow(this.getY() - player.getY(), 2.0) >= Math.pow(rangeMin, 2))
      return true;
    else
      return false;
  }

  void bounceWallRealistic() {
    if (Math.abs(getX() + getXSpeed() - width/2) > (width/2 - 10))
      velocity.set(getXSpeed() * -1, getYSpeed());
    if (Math.abs(getY() + getYSpeed() - height/2) > (height/2 - 10))
      velocity.set(getXSpeed(), getYSpeed() * -1);
  }

  void bounceWallRandom() {
    if ((Math.abs(getX() + getXSpeed() - width/2) > (width/2 - 10)) || 
      (Math.abs(getY() + getYSpeed() - height/2) > (height/2 - 10)))
    {
      do
      {
        velocity.set(random(-5, 5), random(-5, 5));
      } 
      while (5 - Math.abs(getXSpeed()) > 3 && 5 - Math.abs(getYSpeed()) > 3);
      //this loop ensures values from -5 to -2, and 2 to 5, but not small values 
      //for both x and y between -2 and 2.
    }
  }

  private void generateRandomDirection() {
    float angle = random(0, 360);
    velocity.rotate(angle);
    velocity.setMag(float(getSpeed()));
  }

  Float[] slopeTangentLines(Float xmonster, Float ymonster, Float xplayer, Float yplayer, Float radius) {
    Float xcoor = xmonster - xplayer;
    Float ycoor = ymonster - yplayer;
    Float xcoorSquared = (float) Math.pow(xcoor, 2);
    Float ycoorSquared = (float) Math.pow(ycoor, 2);
    Float radiusSquared = (float) Math.pow(radius, 2);
    Float[] answers = new Float[2];
    Float slope1 = (float) ((xcoor * ycoor) + radius * Math.sqrt(xcoorSquared + ycoorSquared - radiusSquared))/(xcoorSquared - radiusSquared);
    Float slope2 = (float) ((xcoor * ycoor) - radius * Math.sqrt(xcoorSquared + ycoorSquared - radiusSquared))/(xcoorSquared - radiusSquared);
    if (slope1 > slope2)
    {
      answers[0] = slope2;
      answers[1] = slope1;
    } else
    {
      answers[0] = slope1;
      answers[1] = slope2;
    }
    return answers;
  }

  void move() {
    if (inRange(50.0, 100.0))
      followPlayer();
    else if (inRange(50.0))
      runFromPlayer();
    else
      wanderRegular(60);

    //if(inRange(50.0))
    //  runFromPlayer();
    //else
    //  followPlayer();

    //jitter();
    //straightLine();
    //wanderRegular(60);
    //wanderSlow(60);
    //followPlayer();
    //runFromPlayer();
  }

  void jitter() {
    generateRandomDirection();
    bounceWallRealistic();
    location.add(velocity);
  }

  void straightLine() {
    bounceWallRealistic();
    location.add(velocity);
  }

  void wanderSlow(Integer k) {
    //if (millis() % 1000 == 1)
    if (frameCount % k == 1)
    {
      generateRandomDirection();
      velocity.setMag(float(getSpeed())/2.0);
    }
    bounceWallRealistic();
    location.add(velocity);
    velocity.setMag(float(getSpeed()));
  }

  void wanderRegular(Integer k) {
    if (frameCount % k == 1)
      generateRandomDirection();
    //Integer modulo = millis() % k;
    //if (modulo < float(k) / 120.0 && modulo >= float(k) / 120.0)
    //  generateRandomDirection();
    bounceWallRealistic();
    location.add(velocity);
  }

  void followPlayer() {
    velocity.set(player.getX() - this.getX(), player.getY() - this.getY());
    velocity.setMag(getSpeed());

    bounceWallRealistic();
    location.add(velocity);
  }

  void runFromPlayer() {
    velocity.set(this.getX() - player.getX(), this.getY() - player.getY());
    velocity.setMag(getSpeed());
    bounceWallRealistic();
    location.add(velocity);
  }

  void circlePlayerClockwise(Float radius) {
    //at every instant, the monster will calculate
    Float xdistance = getX() - player.getX();
    Float ydistance = getY() - player.getY();
    Float[] slopes = slopeTangentLines(getX(), getY(), player.getX(), player.getY(), radius);
    //boolean slope1InRange = (Math.abs(slopes[0]) < Float.POSITIVE_INFINITY);
    boolean slope2InRange = (Math.abs(slopes[1]) < Float.POSITIVE_INFINITY);
    if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) > Math.pow(radius, 2))
    {
      if (getY() < player.getY() && getX() >= player.getX() - radius && getX() <= player.getX() + radius)
      {
        if (slope2InRange)
        {
          System.out.println("greater than");
          velocity.set(1, slopes[1]);
          velocity.setMag(getSpeed());
          bounceWallRealistic();
          location.add(velocity);
        } else
        {
          velocity.set(0, getSpeed());
          velocity.rotate(-1 * getSpeed() / radius);
          bounceWallRealistic();
          location.add(velocity);
        }
      } else if (getX() < player.getX() - radius)
      {
        velocity.set(1, slopes[0]);
        velocity.setMag(getSpeed());
        bounceWallRealistic();
        location.add(velocity);
      } else if (getX() > player.getX() + radius)
      {
        velocity.set(-1, -1 * slopes[0]);
        velocity.setMag(getSpeed());
        bounceWallRealistic();
        location.add(velocity);
      } else
      {
        if (slope2InRange)
        {
          System.out.println("greater than");
          velocity.set(-1, -1 * slopes[1]);
          velocity.setMag(getSpeed());
          bounceWallRealistic();
          location.add(velocity);
        } else
        {
          velocity.set(0, getSpeed());
          velocity.rotate(-1 * getSpeed() / radius);
          bounceWallRealistic();
          location.add(velocity);
        }
      }
    } else if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) < Math.pow(radius, 2))
    {
      System.out.println("less than");
      velocity.set(xdistance, ydistance);
      velocity.setMag(getSpeed());
      bounceWallRealistic();
      location.add(velocity);
    } else if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) == Math.pow(radius, 2))
    {
      System.out.println("equal to");
      velocity.set(-1 * ydistance, xdistance);
      velocity.setMag(getSpeed());
      bounceWallRealistic();
      location.add(velocity);
    }
  }

  void circlePlayerCounterClockwise(Float radius) {
    //at every instant, the monster will calculate
    Float xdistance = getX() - player.getX();
    Float ydistance = getY() - player.getY();
    Float[] slopes = slopeTangentLines(getX(), getY(), player.getX(), player.getY(), radius);
    boolean slope1InRange = (Math.abs(slopes[0]) < Float.POSITIVE_INFINITY);
    //boolean slope2InRange = (Math.abs(slopes[1]) < Float.POSITIVE_INFINITY);
    if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) > Math.pow(radius, 2))
    {
      if (getY() < player.getY() && getX() >= player.getX() - radius && getX() <= player.getX() + radius)
      {
        if (slope1InRange)
        {
          System.out.println("greater than");
          velocity.set(-1, -1 * slopes[0]);
          velocity.setMag(getSpeed());
          bounceWallRealistic();
          location.add(velocity);
        } else
        {
          velocity.set(0, getSpeed());
          velocity.rotate(-1 * getSpeed() / radius);
          bounceWallRealistic();
          location.add(velocity);
        }
      } else if (getX() < player.getX() - radius)
      {
        velocity.set(1, slopes[1]);
        velocity.setMag(getSpeed());
        bounceWallRealistic();
        location.add(velocity);
      } else if (getX() > player.getX() + radius)
      {
        velocity.set(-1, -1 * slopes[1]);
        velocity.setMag(getSpeed());
        bounceWallRealistic();
        location.add(velocity);
      } else
      {
        if (slope1InRange)
        {
          System.out.println("greater than");
          velocity.set(1, slopes[0]);
          velocity.setMag(getSpeed());
          bounceWallRealistic();
          location.add(velocity);
        } else
        {
          velocity.set(0, getSpeed());
          velocity.rotate(-1 * getSpeed() / radius);
          bounceWallRealistic();
          location.add(velocity);
        }
      }
    } else if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) < Math.pow(radius, 2))
    {
      System.out.println("less than");
      velocity.set(xdistance, ydistance);
      velocity.setMag(getSpeed());
      bounceWallRealistic();
      location.add(velocity);
    } else if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) == Math.pow(radius, 2))
    {
      System.out.println("equal to");
      velocity.set(ydistance, -1 * xdistance);
      velocity.setMag(getSpeed());
      bounceWallRealistic();
      location.add(velocity);
    }
  }
}

//CHASER
class Chaser extends Monster {
  Chaser(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {//equilateral triangle, or triangle with height = player height and base = player height?
    //PVector point2 = new PVector(-2,1);
    //PVector point3 = new PVector(2,1);
    //point2.setMag(5);
    //point3.setMag(5);
    //model = createShape(TRIANGLE, getX(), getY() - 5, getX() + point2.x, getY() + point2.y, getX() + point3.x, getY() + point3.y);
    model = createShape(TRIANGLE, getX(), getY() - 5, getX() - 5, getY() + 5, getX() + 5, getY() + 5);
    model.setFill(color(255, 0, 0));
    shape(model);
  }

  void move() {
    //if(inRange(50.0, 100.0))
    //{
    //  followPlayer();
    //}
    //else if(inRange(50.0))
    //{
    //  runFromPlayer();
    //}
    //else
    //{
    //  wanderRegular(60);
    //}

    if (inRange(50.0))
      runFromPlayer();
    else
      followPlayer();
  }
}

//COWARD
class Coward extends Monster {
  Coward(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {
    model = createShape(TRIANGLE, getX(), getY() - 5, getX() - 5, getY() + 5, getX() + 5, getY() + 5);
    model.setFill(color(255, 255, 0));
    shape(model);
  }

  void move() {
    if (inRange(100.0))
    {
      runFromPlayer();
    } else
    {
      wanderRegular(60);
    }
  }
}

//CIRCLER
class Circler extends Monster {
  Circler(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {
    ellipseMode(CENTER);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 255));
    shape(model);
  }

  void move() {
    circlePlayerCounterClockwise(100.0);
  }
}