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
      return 750 - (float)(Math.random() * 246 + 100);
    }
  }

  int getRoom() {
    return roomNumber;
  }

  void increaseRoom() {
    roomNumber++;
  }

  void createRoom() {
    if (roomNumber % 5 != 0) {
      enemies = (int) (Math.random() * 5) + 3;
      for (int i = 0; i < enemies; i++) {
        enemyType = (int) (Math.random() * 4);
        if (enemyType == 0) {
          thingsToDisplay.add(new Chaser(randomX(), randomY(), 5, 1, 1, player));
          thingsToMove.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
          thingsToShoot.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
        }
        if (enemyType == 1) {
          thingsToDisplay.add(new Coward(randomX(), randomY(), 5, 1, 1, player));
          thingsToMove.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
          thingsToShoot.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
        }
        if (enemyType == 2) {
          thingsToDisplay.add(new Circler(randomX(), randomY(), 5, 1, 1, player));
          thingsToMove.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
          thingsToShoot.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
        }
        if (enemyType == 3) {
          thingsToDisplay.add(new StationaryShooter(randomX(), randomY(), 5, 1, 1, player));
          thingsToMove.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
          thingsToShoot.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
        }
      }
    } else {
      thingsToDisplay.add(new FirstBoss(500.0, 350.0, 100, 1, 1, player));
      thingsToMove.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
      thingsToShoot.add(thingsToDisplay.get(thingsToDisplay.size() - 1));
    }
  }
}
