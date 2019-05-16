class FloatingText
{
  //variables
  float spawnTime; //amount of time "alive"
  PVector pos; //position
  String text; //text to display
  int size; //text size
  float alpha; //opacity
  
  //overloaded constructor
  FloatingText(String _text, float x, float y, int _size)
  {
    pos = new PVector (x,y);
    spawnTime = millis();
    text = _text;
    alpha = 255;
    size = _size;
  }
  
  //text displayed
  void Render()
  {
    textAlign(CENTER);
    textSize(size);
    fill(255,alpha);
    text(text, pos.x, pos.y);
    alpha -= 2.5; //decrease opacity over time until it disappears
  }
}
