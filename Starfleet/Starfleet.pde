import processing.sound.*; //import sound library

//sound code
SoundFile file;

//main code variables
String rank = "Cadet";
boolean showStaffScreen; //staff screen controller
float Posdifference; //raid controls
float Negdifference;
float lastRaid = 0; //raid timing controls
float raidReload = 2500;
int CadetStaff; //staff controls (incomplete, only CommandStaff is working)
int MidStaff;
int CommandStaff;
FloatingText raidResult; //floating text 

int scene = 1; //scene controller
//initializing classes
Ship ship;
Intrepid Intrepid;
ArrayList<Objects> objects  = new ArrayList();
Objects o = new Objects();

float wallet = 10000; //money that the user has
float raidControl; //raid controller

//object spawn controller
float objTime = 1000;
float lastSpawned;

PImage sisko; //sisko image

void setup()
{
  size(1820, 980);
  //classes intialize
  ship = new Ship();
  Intrepid = new Intrepid();
  wallet += ship.price;
  
  //image loading
  sisko = loadImage("Sisko.jpg");
  sisko.resize(100,100);
  
  //music code pt. 2
  file = new SoundFile(this, "musicstartrek1.mp3");
  file.loop();
}

void draw()
{
  fill(0, 50);
  rect(0, 0, width, height);

//show the result of a raid if it is not = nothing
  if(raidResult != null)
  {
    raidResult.Render();
  }

//display vars using text
  fill(255);
  text("Money: "+ wallet, 100, 250); 
  text(rank, width/2, 200);

//code for objects (stars) moving past
  if (millis() - lastSpawned > objTime)
  {
    objects.add(new Objects());
    lastSpawned = millis();
  }
  
  for (int i = objects.size() -1; i>=0; i--)
  {
    objects.get(i).update();
  }

  if (scene == 1)
  {
    defaultShip();
  }

  if (scene == 2)
  {
    Intrepid();
  }

  if (scene == 3)
  {
    endScene();
  }
  
  if(scene == 4)
  {
    StaffScene();
  }
}

void raid() //all the code for raids - how the user earns money
{

  fill(255);
  text("Press R to raid another ship", 1500, 300);
  
  textAlign(CENTER);

  if (millis() - lastRaid > raidReload)
  {

    if (keyPressed)
    {
      if (key == 'r')
      {
        lastRaid = millis();
        raidControl = random(0, 100);
        if (raidControl >= (20-CommandStaff*2)) //raid outcome likelihood to be positive is influenced by staff
        {
          Posdifference = random(400, 1000);
          wallet += Posdifference;
          //display outcome
          raidResult = new FloatingText("Raid Won! You won " + Posdifference + " dollars", width/2, 700, 20);
          //text("Raid Won! You won " + Posdifference + " dollars", width/2, 700);
        } else if (raidControl <= 20) //raid outcome likelihood for negative
        {
          //add/subtract money based on outcome
          Negdifference = random(400, 1000);
          wallet -= Negdifference;
          raidResult = new FloatingText("Raid Lost! You lost " + Negdifference + " dollars", width/2, 700, 20);
          ship.health -= 40;
          if (scene == 2)
          {
            Intrepid.health -= 40;
          }
        }
      }
    }
  }
}

//starting ship code with default vars and calling upon
void defaultShip()
{
  ship.update();
  raid();

  rank = "Cadet";

//upgrade to the Intrepid after you have enough money
  if (wallet >= 22000)
  {
    text("Press '2' to Upgrade to the Intrepid", width/2, 700);
    if (keyPressed)
    {
      if (key == '2')
      {
        scene = 2;
      }
    }
  }

  if (ship.health <= 0)
  {
    scene = 3;
  }
}

void Intrepid()
{

  rank = "Crewman";
  text("Press S to hire staff", width/2, 800);

  Intrepid.update();
  raid();

  if (Intrepid.health < 0)
  {
    scene = 3;
  }
  if(showStaffScreen == true)
  {
    StaffScene();
  }
}

//end/restart screen
void endScene()
{
  fill(255);
  text("Your ship has been destroyed. Starfleet Command is not happy. Press SPACE to restart.", width/2 - 200, height/2);
  if (keyPressed)
  {
    if (key == ' ')
    {
      scene = 1;
      ship.health = 100;
      wallet = 20000;
    }
  }
}

//to hire staff
void StaffScene()
{
  if(showStaffScreen == true)
  {
  rect(width/2-400, height/2-400, 800, 800);
  fill(0);
  textAlign(CENTER);
  text("Hire Staff", width/2, height/2-350);
  tint(255);
  image(sisko, width/2-300, height/2-250);
  fill(0);
  text("Raid Win %+, 2000$", width/2-300, height/2-450);
  }
}

void keyReleased()
{
  if(key == 's')
  {
    showStaffScreen =! showStaffScreen;
  }
}

void mouseReleased()
{
  
  //subtract money if staff is clicked
  if(showStaffScreen == true)
  {
     if(dist(width/2-300, height/2-250, mouseX, mouseY)<100)
    {
      if(wallet>2000)
      {
        wallet -= 2000;
        CommandStaff += 1;
      }
    }
  }
}
