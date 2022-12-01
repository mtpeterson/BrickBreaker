class Player {
  int x;
  int y;
  int w;
  int h;
  color fillC;
  int speed;
  
  Player() {
    x = width/2;
    y = height - 70;
    w = 120;
    h = 30;
    fillC = color(255);
    speed = 10;
    rectMode(CENTER);
  }
  
  void render(){
    fill(fillC);
    rect(x,y,w,h);
  }
  
  void moveL(){
    if(x - w/2 > 0){
      x -= speed;
    }
  }
  //What????? How does this work without brackets?
  void moveR(){
    if(x + w/2 < width)
    x += speed;
  }
}
