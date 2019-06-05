//ROOM
class Room {
  int roomNumber;
  int enemies;
  int enemyType;

  Room() {
    roomNumber = 1;
  }

  float randomX() {
    if (Math.random() < 0.5) {
      return (float)(Math.random() * 301 + 100);
    } else {
      return (float)(Math.random() * 301 + 600);
    }
  }

  float randomY() {
    if (Math.random() < 0.5) {
      return (float)(Math.random() * 246 + 100);
    } else {
      return (float)(Math.random() * 404 + 600);
    }
  }

  void createRoom() {
    if (roomNumber % 5 != 0) {
      enemies = (int) (Math.random() * 5) + 3;
      for (int i = 0; i < enemies; i++) {
        enemyType = (int) (Math.random() * 4);
        if (enemyType == 0) {
          Chaser chaser = new Chaser(randomX(), randomY(), 5, 1, 1, player);
          thingsToDisplay.add(chaser);
          thingsToMove.add(chaser);
          //thingsToShoot.add(chaser);
        }
        if (enemyType == 1) {
          Coward coward = new Coward(randomX(), randomY(), 5, 1, 1, player);
          thingsToDisplay.add(coward);
          thingsToMove.add(coward);
          //thingsToShoot.add(coward);
        }
        if (enemyType == 2) {
          Circler circler = new Circler(randomX(), randomY(), 5, 1, 1, player);
          thingsToDisplay.add(circler);
          thingsToMove.add(circler);
          //thingsToShoot.add(circler);
        }
        if (enemyType == 3) {
          StationaryShooter stationaryShooter = new StationaryShooter(randomX(), randomY(), 5, 1, 1, player);
          thingsToDisplay.add(stationaryShooter);
          thingsToMove.add(stationaryShooter);
          //thingsToShoot.add(stationaryShooter);
        }
      }
    }
  }
}
