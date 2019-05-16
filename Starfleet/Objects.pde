class Objects //stars floating past the ship
{
  //position and direction
  PVector pos;
  PVector dir;
  
  //default constructor
  Objects()
  {
    pos = new PVector(1800, random(0,980));
    dir = new PVector(random(-3, -6), 0);
  }
 
  //movement and rendering
  void update()
  {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, 20, 20);
    pos.add(dir);
  }
}
