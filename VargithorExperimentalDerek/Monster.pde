//MONSTER
class Monster extends Entity implements Alive {
  Integer health, strength, speed, maxHealth;
  PShape model;
  Player player;
  boolean playerDetected;
  Integer frameOnEncounter;

  Monster(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy);
    maxHealth = h;
    health = h;
    strength = str;
    speed = spd;
    generateRandomDirection();
    player = givenPlayer;
    playerDetected = false;
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 0));
    shape(model);
    if (health <= 0) {
      this.die();
    }
    takeDamage();
  }

  void detectPlayer(Float range) {
    if (!playerDetected)
    {
      if (inRange(range))
      {
        playerDetected = true;
        frameOnEncounter = frameCount;
      }
    } else
    {
      if (!inRange(range))
      {
        playerDetected = false;
      }
    }
  }

  boolean isColliding(Entity other) {
    if (Math.sqrt((other.getX() - this.getX()) * (other.getX() - this.getX()) + (other.getY() - this.getY()) * (other.getY() - this.getY())) <= 5.5) {
      return true;
    }
    return false;
  }

  boolean isColliding(myBullet other, int life) {
    if (life <= 1 && Math.sqrt((other.getOriginalX() - this.getX()) * (other.getOriginalX() - this.getX()) + (other.getOriginalY() - this.getY()) * (other.getOriginalY() - this.getY())) <= 5.5) {
      return true;
    }
    return false;
  }

  void takeDamage() {
    for (int i = 0; i < bullets.size(); i++) {
      myBullet bullet = bullets.get(i);
      if (isColliding(bullet) || isColliding(bullet, bullet.getLifetime())) {
        if (bullet.getType().equals("allied")) {
          this.setHealth(this.getHealth() - bullet.getStrength());
          i--;
          bullets.remove(bullet);
        }
      }
    }
  }

  void die() {
    thingsToDisplay.remove(this);
    thingsToMove.remove(this);
    thingsToShoot.remove(this);
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

  boolean inRange(Float range) {
    //equation of circle around player is (x - player.getX()) ^ 2 + (y - getY()) ^ 2 = radius ^2;
    return inRange(0.0, range);
  }

  boolean inRange(Float rangeMin, Float rangeMax) {
    if (Math.pow(this.getX() - player.getX(), 2.0) + Math.pow(this.getY() - player.getY(), 2.0) < Math.pow(rangeMax, 2) && 
      Math.pow(this.getX() - player.getX(), 2.0) + Math.pow(this.getY() - player.getY(), 2.0) >= Math.pow(rangeMin, 2))
      return true;
    else
      return false;
  }
  
  PVector randomAim() {
    float heading = random(-PI, PI);
    return PVector.fromAngle(heading);
  }

  PVector aimAtPlayer() {
    return new PVector(player.getX() - getX(), player.getY() - getY());
  }

  PVector leadPlayer(Float bulletSpeed) {
    Float playerVelocity = (float) player.getSpeed();
    Float xdistance = player.getX() - getX();
    Float ydistance = player.getY() - getY();
    PVector playerToMonsterDistance = new PVector(-1 * xdistance, -1 * ydistance);
    Float angleBetweenMonsterPlayerVelocityAndPlayerVelocity = PVector.angleBetween(playerToMonsterDistance, player.velocity);
    Float monsterPlayerVelocity = (float) (playerVelocity * cos(angleBetweenMonsterPlayerVelocityAndPlayerVelocity)) + (float) Math.sqrt(Math.pow(playerVelocity * cos(angleBetweenMonsterPlayerVelocityAndPlayerVelocity), 2) - Math.pow(playerVelocity, 2) + Math.pow(bulletSpeed, 2));
    Float theta = acos((float)(Math.pow(playerVelocity, 2) - Math.pow(monsterPlayerVelocity, 2) - Math.pow(bulletSpeed, 2)) / (-2.0 * monsterPlayerVelocity * bulletSpeed));
    //System.out.println("monsterPlayerVelocity: " + monsterPlayerVelocity);
    //System.out.println("bulletSpeed: " + bulletSpeed);
    //System.out.println("-2 times that: " + (-2.0 * monsterPlayerVelocity * bulletSpeed));
    PVector monsterToPlayer = new PVector(xdistance, ydistance);
    PVector playerLocation = new PVector(player.getX(), player.getY());
    PVector newLocation = playerLocation.add(player.velocity);
    PVector predictedTemporaryMonsterToPlayer = new PVector(newLocation.x - getX(), newLocation.y - getY());
    if (predictedTemporaryMonsterToPlayer.heading() - monsterToPlayer.heading() < 0 &&
      !(predictedTemporaryMonsterToPlayer.heading() <= 0 && monsterToPlayer.heading() > 0 && player.getX() < getX()) ||
      predictedTemporaryMonsterToPlayer.heading() > 0 && monsterToPlayer.heading() <= 0 && player.getX() < getX())
      theta *= -1;
    monsterToPlayer.setMag(bulletSpeed);
    Float discriminant = (float)(Math.pow(playerVelocity * cos(angleBetweenMonsterPlayerVelocityAndPlayerVelocity), 2) - Math.pow(playerVelocity, 2) + Math.pow(bulletSpeed, 2));
    monsterToPlayer.rotate(theta);
    //System.out.println(discriminant);
    if (discriminant < 0 || monsterPlayerVelocity <= 0)
      return aimAtPlayer();
    else
      return monsterToPlayer;
  }

  void shoot() {
  }
  
  void singleShoot(PVector direction, Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife) {
    PVector monsterToPlayer = direction;
    myBullet bullet = new myBullet(bulletStrength, this, getX() + monsterToPlayer.x, getY() + monsterToPlayer.y, bulletSpeed);
    bullet.size = bulletSize;
    bullet.lifeSpan = bulletLife;
    bullets.add(bullet);
  }
  
  void circleShoot(PVector direction, Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets) {
    PVector monsterToPlayer = direction;
    float fixedHeading = monsterToPlayer.heading();
    float heading = monsterToPlayer.heading();
    float headingDifference;
    Integer i = 0;
    while (i < numberOfBullets)
    {
      headingDifference = (i * 2 * PI) / numberOfBullets;
      heading = fixedHeading + headingDifference;
      monsterToPlayer = PVector.fromAngle(heading);
      myBullet bullet = new myBullet(bulletStrength, this, getX() + monsterToPlayer.x, getY() + monsterToPlayer.y, bulletSpeed);
      bullet.size = bulletSize;
      bullet.lifeSpan = bulletLife;
      bullets.add(bullet);
      i ++;
    }
  }
  
  void spreadShoot(PVector direction, Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float angleOfSpread, Integer numberOfBullets) {
    PVector monsterToPlayer = direction;
    float fixedHeadingStart = monsterToPlayer.heading() - angleOfSpread;
    float heading = fixedHeadingStart;
    Float fullAngle = Math.abs(angleOfSpread * 2);
    Integer i = 0;
    while(i < numberOfBullets)
    {
      Float headingDifference = ((float) i * fullAngle / ((float) numberOfBullets - 1));
      heading = fixedHeadingStart + headingDifference;
      monsterToPlayer = PVector.fromAngle(heading);
      myBullet bullet = new myBullet(bulletStrength, this, getX() + monsterToPlayer.x, getY() + monsterToPlayer.y, bulletSpeed);
      bullet.size = bulletSize;
      bullet.lifeSpan = bulletLife;
      bullets.add(bullet);
      i ++;
    }
  }
  
  void ringOfRingsShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float rangeBigRing, Integer numberOfRings, Integer bulletsPerRing) {
    int i = 0;
    ArrayList<StationaryShooter> stationaryShooterLocations = new ArrayList<StationaryShooter>(numberOfRings);
    while(i < numberOfRings)
    {
      Float ringHeading = (PI * i * 2) / numberOfRings;
      PVector ringDirection = PVector.fromAngle(ringHeading);
      ringDirection.setMag(rangeBigRing);
      StationaryShooter stationaryShooter = new StationaryShooter(getX() + ringDirection.x, getY() + ringDirection.y, 1000000, 0, 0, player);
      stationaryShooterLocations.add(stationaryShooter);
      i ++;
    }
    for(i = 0 ; i < stationaryShooterLocations.size() ; i ++)
    {
      int m = 0;
      while(m < bulletsPerRing)
      {
        Float bulletHeading = (PI * m * 2) / bulletsPerRing;
        PVector bulletDirection = PVector.fromAngle(bulletHeading);
        StationaryShooter theShooter = stationaryShooterLocations.get(i);
        myBullet bullet = new myBullet(bulletStrength, theShooter, theShooter.getX() + bulletDirection.x, theShooter.getY() + bulletDirection.y, bulletSpeed);
        bullet.size = bulletSize;
        bullet.lifeSpan = bulletLife;
        bullets.add(bullet);
        m ++;
      }
    }
  }
  
  void rotatingRingOfRingsShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float rangeBigRing, Integer numberOfRings, Integer bulletsPerRing, Float angularVelocity) {
    int i = 0;
    ArrayList<StationaryShooter> stationaryShooterLocations = new ArrayList<StationaryShooter>(numberOfRings);
    while(i < numberOfRings)
    {
      Float angleVelocityChange = frameCount * angularVelocity;
      Float ringHeading = (PI * i * 2) / numberOfRings + angleVelocityChange;
      PVector ringDirection = PVector.fromAngle(ringHeading);
      ringDirection.setMag(rangeBigRing);
      StationaryShooter stationaryShooter = new StationaryShooter(getX() + ringDirection.x, getY() + ringDirection.y, 1000000, 0, 0, player);
      stationaryShooterLocations.add(stationaryShooter);
      i ++;
    }
    for(i = 0 ; i < stationaryShooterLocations.size() ; i ++)
    {
      int m = 0;
      while(m < bulletsPerRing)
      {
        Float bulletHeading = (PI * m * 2) / bulletsPerRing;
        PVector bulletDirection = PVector.fromAngle(bulletHeading);
        StationaryShooter theShooter = stationaryShooterLocations.get(i);
        myBullet bullet = new myBullet(bulletStrength, theShooter, theShooter.getX() + bulletDirection.x, theShooter.getY() + bulletDirection.y, bulletSpeed);
        bullet.size = bulletSize;
        bullet.lifeSpan = bulletLife;
        bullets.add(bullet);
        m ++;
      }
    }
  }
  
  void rotatingTentaclesShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets, Float angularVelocity)
  {//angularVelocity is radians per time, here would be radians per frame
    Float heading = frameCount * angularVelocity;
    PVector bulletDirection = PVector.fromAngle(heading);
    circleShoot(bulletDirection, bulletStrength, bulletSpeed, bulletSize, bulletLife, numberOfBullets);
  }
  
  void randomAimShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife) {
    singleShoot(randomAim(), bulletStrength, bulletSpeed, bulletSize, bulletLife);
  }

  void shootAtPlayer(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife) {
    singleShoot(aimAtPlayer(), bulletStrength, bulletSpeed, bulletSize, bulletLife);
  }

  void leadPlayerShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife) {
    singleShoot(leadPlayer(bulletSpeed), bulletStrength, bulletSpeed, bulletSize, bulletLife);
  }
  
  void circleRandomAimShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets) {
    circleShoot(randomAim(), bulletStrength, bulletSpeed, bulletSize, bulletLife, numberOfBullets);
  }

  void circleShootAtPlayer(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets) {
    circleShoot(aimAtPlayer(), bulletStrength, bulletSpeed, bulletSize, bulletLife, numberOfBullets);
  }

  void circleLeadPlayerShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets) {
    circleShoot(leadPlayer(bulletSpeed), bulletStrength, bulletSpeed, bulletSize, bulletLife, numberOfBullets);
  }
  
  void spreadRandomShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float angleOfSpread, Integer numberOfBullets) {
    spreadShoot(randomAim(), bulletStrength, bulletSpeed, bulletSize, bulletLife, angleOfSpread, numberOfBullets);
  }
  
  void spreadShootAtPlayer(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float angleOfSpread, Integer numberOfBullets) {
    spreadShoot(aimAtPlayer(), bulletStrength, bulletSpeed, bulletSize, bulletLife, angleOfSpread, numberOfBullets);
  }
  
  void spreadLeadPlayerShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float angleOfSpread, Integer numberOfBullets) {
    spreadShoot(leadPlayer(bulletSpeed), bulletStrength, bulletSpeed, bulletSize, bulletLife, angleOfSpread, numberOfBullets);
  }

  void move() {
    if (inRange(50.0, 100.0))
      followPlayer();
    else if (inRange(50.0))
      runFromPlayer();
    else
      wanderRegular(60);
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
    float angle = random(-PI, PI);
    velocity = PVector.fromAngle(angle);
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
      velocity.set(xdistance, ydistance);
      velocity.setMag(getSpeed());
      bounceWallRealistic();
      location.add(velocity);
    } else if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) == Math.pow(radius, 2))
    {
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
      velocity.set(xdistance, ydistance);
      velocity.setMag(getSpeed());
      bounceWallRealistic();
      location.add(velocity);
    } else if (Math.pow(xdistance, 2) + Math.pow(ydistance, 2) == Math.pow(radius, 2))
    {
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

  void display() {
    ellipseMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 150, 0));
    model.setStroke(color(0));
    shape(model);
    if (health <= 0) {
      this.die();
    }
    takeDamage();
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

  void shoot() {
    super.shoot();
  }
}

//COWARD
class Coward extends Monster {
  Coward(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 255, 0));
    model.setStroke(color(0));
    shape(model);
    if (health <= 0) {
      this.die();
    }
    takeDamage();
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

  void shoot() {
    super.shoot();
  }
}

//CIRCLER
class Circler extends Monster {
  Circler(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(255, 0, 255));
    model.setStroke(color(0));
    shape(model);
    if (health <= 0) {
      this.die();
    }
    takeDamage();
  }

  void move() {
    circlePlayerCounterClockwise(100.0);
  }

  void shoot() {
    super.shoot();
  }
}

//STATIONARYSHOOTER
class StationaryShooter extends Monster {
  StationaryShooter(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(0));
    model.setStroke(color(255, 0, 0));
    shape(model);
    if (health <= 0) {
      this.die();
    }
    takeDamage();
  }

  void move() {
  }

  void shoot() {
    if (!playerDetected)
      detectPlayer(1000.0);
    else
    {
      if ((frameCount - frameOnEncounter) % 5 == 0)
      {
        //circleLeadPlayerShoot(5, 3.0, 10, 100, 6);//circleRandomAimShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets)
        rotatingTentaclesShoot(1, 5.0, 10, 100, 8, PI/240);//rotatingTentaclesShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Integer numberOfBullets, Float angularVelocity)
      }
      detectPlayer(1000.0);
    }
  }
}

class FirstBoss extends Monster {
  boolean phase1 = false;
  boolean phase2 = false;
  boolean phase3 = false;
  boolean phase4 = false;
  FirstBoss(Float newx, Float newy, Integer h, Integer str, Integer spd, Player givenPlayer) {
    super(newx, newy, h, str, spd, givenPlayer);
  }

  void display() {
    ellipseMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 10, 10);
    model.setFill(color(200));
    model.setStroke(color(0, 0, 0));
    shape(model);
    if ((float)health / (float)maxHealth > 0.75)
    {
      phase1 = true;
    } else if ((float)health / (float)maxHealth > 0.50)
    {
      phase1 = false;
      phase2 = true;
    } else if ((float)health / (float)maxHealth > 0.25)
    {
      phase2 = false;
      phase3 = true;
    } else if ((float)health / (float)maxHealth > 0.0)
    {
      phase3 = false;
      phase4 = true;
    } else if (health <= 0) {
      phase4 = false;
      this.die();
    }
    takeDamage();
  }

  void move() {
    if (phase1)
    {
    } else if (phase2)
    {
      circlePlayerClockwise(100.0);
    } else if (phase3)
    {
      jitter();
    } else if (phase4)
    {
    }
  }

  void shoot() {
    if (phase1)
    {
      if (!playerDetected)
        detectPlayer(10000.0);
      else
      {
        if ((frameCount - frameOnEncounter) % 10 == 0)
        {
          circleRandomAimShoot(1, 1.0, 10, 200, 6);//circleRandomAimShoot(bulletStrength, bulletSpeed, bulletSize, bulletLife, numberOfBullets);
        }
        if ((frameCount - frameOnEncounter) % 20 == 0)
        {
          ringOfRingsShoot(20, 8.0, 30, 10, 280.0, 10, 10);//ringOfRingsShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float rangeBigRing, Integer numberOfRings, Integer bulletsPerRing)
          //rotatingRingOfRingsShoot(20, 8.0, 30, 10, 280.0, 10, 10, PI/240);//rotatingRingOfRingsShoot(Integer bulletStrength, Float bulletSpeed, Integer bulletSize, Integer bulletLife, Float rangeBigRing, Integer numberOfRings, Integer bulletsPerRing, Float angularVelocity)
        }
        detectPlayer(10000.0);
      }
    } else if (phase2)
    {
      if (!playerDetected)
        detectPlayer(10000.0);
      else
      {
        if ((frameCount - frameOnEncounter) % 20 == 0)
        {
          circleLeadPlayerShoot(5, 9.0, 20, 100, 6);//circleRandomAimShoot(bulletStrength, bulletSpeed, bulletSize, bulletLife, numberOfBullets);
        }
        detectPlayer(10000.0);
      }
    } else if (phase3)
    {
      if (!playerDetected)
        detectPlayer(10000.0);
      else
      {
        if ((frameCount - frameOnEncounter) % 5 == 0)
        {
          rotatingTentaclesShoot(1, 5.0, 10, 100, 8, PI/240);
        }
        detectPlayer(10000.0);
      }
    } else if (phase4)
    {
    }
  }
}
