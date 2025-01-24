public class Box
{
  PVector position, localScale;
  
  Box(PVector position, PVector localScale)
  {
    this.position = position;
    this.localScale = localScale;
  }
  
  public void Update()
  {
    noStroke();
    fill(255);
    
    pushMatrix();
      translate(position.x, position.y, position.z);
      box(localScale.x, localScale.y, localScale.z);
    popMatrix();
  }
  
  public ArrayList<Box> OnBoxClicked()
  {
    ArrayList<Box> boxes = new ArrayList<Box>(); 
    
    for (int x = -1; x < 2; x++)
    {
      for (int y = -1; y < 2; y++)
      {
        for (int z = -1; z < 2; z++)
        {
          int sum = abs(x) + abs(y) + abs(z);
          if (sum <= 1)
          {
            numberOfHoles++;
            continue;
          }
          
          PVector newScale = new PVector((localScale.x / 3), (localScale.y / 3), (localScale.z / 3));
          Box box = new Box(new PVector(position.x + x * newScale.x, position.y + y * newScale.y, position.z + z * newScale.z), newScale);
          boxes.add(box);
        }
      }
    }
    
    return boxes;
  }
}
