
Float[] calculateSlopeOfTangentToCircleCenteredAtOriginFromExternalPoint(Float xcoor, Float ycoor, Float radius)
{
  Float xcoorSquared = (float) Math.pow(xcoor, 2);
  Float ycoorSquared = (float) Math.pow(ycoor, 2);
  Float radiusSquared = (float) Math.pow(radius, 2);
  Float[] answers = new Float[2];
  answers[0] = (float) ((xcoor * ycoor) + radius * Math.sqrt(xcoorSquared + ycoorSquared - radiusSquared))/(xcoorSquared - radiusSquared);
  answers[1] = (float) ((xcoor * ycoor) - radius * Math.sqrt(xcoorSquared + ycoorSquared - radiusSquared))/(xcoorSquared - radiusSquared);
  return answers;
}


void setup(){}
void draw(){
  Float[] holyGrail = calculateSlopeOfTangentToCircleCenteredAtOriginFromExternalPoint(7.0, 6.0, 5.0);

  System.out.println(holyGrail[0]);//should print 3.36374306092
  System.out.println(holyGrail[1]);//should print 0.13625693908

}
