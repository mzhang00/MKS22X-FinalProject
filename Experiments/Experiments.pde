void setup()
{
  size(1000, 700);
}


void draw()
{
  background(255);
  fill(0, 128);
  rectMode(CORNER);
  rect(250, 175, 500, 350, 25);
  String healthText = "Health: " + 5;
  //textSize(14);//when this line is commented in, text does not display
  fill(0, 255, 0);   
  text(healthText, 300, 225, 100, 15);
}
