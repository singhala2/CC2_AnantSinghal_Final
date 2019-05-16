class Ship //default ship at the start
{
  
  //variables
  PImage shipside;
  PVector pos;
  PVector dir;
  float c;
  float capacity; //no. of crew
  float health;
  float price;
  
  float healthTime; //health regen controller
  
  //default constructor
  Ship()
  {
    shipside = loadImage("peregrine1.png");
    shipside.resize(300,300);
    pos = new PVector(width/2-150,height/2-150);
    dir = new PVector();
    capacity = 100;
    health = 100;
    price = capacity*health;
    c = random(150,255);
  }
  
  
  //movement, render, change of variables
  void update()
  {
    fill(255);
    textSize(20);
    text(health + " HP", 100, 100);
    text("Capacity: " + capacity + " crew", 100, 150);
    text("Price: $" + price, 100, 200);
    
    if(health < 100)
    {
      
      if(millis() - healthTime > 1000)
      {
        healthTime = millis();
        health += random(3,5);
      }
    }
    
    for(int i=0; i<20; i++)
    {
      noStroke();
      tint(c,255-i*100000);
      image(shipside, pos.x-(i*50), pos.y);
    }
    pos.add(dir);
    
    if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height)
    {
      dir.mult(random(-1.5, -0.5));
    }    
  }
  
}
