class Item extends Entity {

  Item(float nx, float ny) {
    super(nx, ny);
  }

  void display() {
    rectMode(CENTER);
    stroke(0);
    model = createShape(ELLIPSE, getX(), getY(), 100, 100);
    model.setStroke(color(255, 0, 0));
    model.setFill(color(255, 0, 0));
    shape(model);
  }
}
