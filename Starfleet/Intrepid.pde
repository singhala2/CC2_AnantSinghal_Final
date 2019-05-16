class Intrepid extends Ship //class extension of ship
{
  
  //additionall variables
  float raidControl;
  PImage intrepid;
  
  //default constructor
  Intrepid()
  {
    c = 255;
    capacity = 1000;
    health = 200;
    intrepid = loadImage("intrepid.jpg");
    intrepid.resize(300,300);
  }
  
  void update()
  {
    
    fill(255);
    textSize(20);
    text(health + " HP", 100, 100);
    text("Capacity: " + capacity + " crew", 100, 150);
    text("Price: $" + price, 100, 200);
    
    //creates the trailing effect
   for(int i=0; i<20; i++)
    {
      noStroke();
      tint(c,255-i*80);
      image(intrepid, pos.x-(i*15), pos.y);
    }
    pos.add(dir);
    
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height)
    {
      dir.mult(random(-1.5, -0.5));
    }
       
        if(health < 200)
    {
     //health regeneration 
      if(millis() - healthTime > 1000)
      {
        healthTime = millis();
        health += random(3,5);
      }
    }
  }
}
