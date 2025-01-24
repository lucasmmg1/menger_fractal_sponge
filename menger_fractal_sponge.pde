int numberOfHoles;
PVector rotationAngle;
ArrayList<Box> spongeBoxes;

public void setup()
{
  size(800, 750, P3D);
  rotationAngle = new PVector(0, 0, 0);
  spongeBoxes = new ArrayList<Box>();
  spongeBoxes.add(new Box(new PVector(0, 0, 0), new PVector(200, 200, 200)));
}
public void draw()
{
  background(51);
  lights();

  textSize(20);
  fill(225, 175, 60);
  text("Menger Fractal Sponge", 10, 30);
  fill(225);
  text("Wikipedia Link: ", 10, 60);
  fill(0, 105, 205);
  text("https://en.wikipedia.org/wiki/Menger_sponge", 15 + textWidth("Wikipedia Link: "), 60);
  fill(225);
  text("Number of holes: ", 10, 90);
  fill(225, 0, 0);
  text(numberOfHoles, 15 + textWidth("Number of holes: "), 90.5f);
  
  translate(width / 2, height / 2 + 100);
  rotateX(rotationAngle.x);
  rotateY(rotationAngle.y);
  rotateZ(rotationAngle.z);

  for (Box spongeBox : spongeBoxes)
    spongeBox.Update();

  rotationAngle = new PVector(rotationAngle.x + 0.01f, rotationAngle.y + 0.01f, rotationAngle.z + 0.01f);
}
public void mousePressed()
{
  ArrayList<Box> smallerBoxes = new ArrayList<Box>();

  for (Box spongeBox : spongeBoxes)
  {
    ArrayList<Box> tempSmallerBoxes = spongeBox.OnBoxClicked();
    smallerBoxes.addAll(tempSmallerBoxes);
  }

  spongeBoxes = smallerBoxes;
}
