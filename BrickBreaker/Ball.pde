class Ball { 
  /*
  Class variables
   */
  int x; // x pos of the ball
  int y; // y pos of the ball
  int d; // diameter of the ball
  color fillColor; // color of the ball's fill
  int r;

  float xSpeed; // the speed the ball moves in the x direction
  float ySpeed; // the speed the ball moves in the y direction
  
  float actualSpeed;

  /*
  Constructor
  */

  Ball() {
    // initial values of all the variables
    float speedMag = 10;
    
    actualSpeed = 12;
    //xSpeed = int(random(-speedMag, speedMag));
    xSpeed = random(-speedMag,speedMag);
    while(xSpeed < 0.5 && xSpeed > -0.5){
      xSpeed = random(-speedMag,speedMag);
    }
    //ySpeed = int(random(-speedMag, speedMag));
    ySpeed = -sqrt(15*15 - (xSpeed*xSpeed));

    //if (xSpeed == 0) {
    //  xSpeed = speedMag;
    //}
    //if (ySpeed == 0) {
    //  ySpeed = speedMag;
    //}
    
    //actualSpeed = sqrt((ySpeed*ySpeed)+(xSpeed*xSpeed));

    d = 25;
    r = int(d/2);
    x = p1.x;
    y = p1.y - p1.h/2 - r;
    fillColor = color(255);
  }

/*
draws the ball
*/
  void render() {
    fill(fillColor);
    circle(x, y, d);
  }

  /*
This function takes updates the position the ball according to its speed.
   */
  void move() {
    x += xSpeed;
    y += ySpeed;
  }

  /*
This function checks if the ball is touching an edge. If it is, the speed flips
   */
  void wallDetect(SoundFile sound) {
    // detects wall detection for the right wall
    if (x+d/2 >= width) {
      xSpeed = -abs(xSpeed);
      sound.play();
    }
    // wall detection for left wall
    if (x-d/2 <= 0) {
      xSpeed = abs(xSpeed);
      sound.play();
    }

    // wall detection for the bottom wall
    if (y+d/2 >= height) {
      ballExists = false;
      state = 9;
    }
    // wall detection for top wall
    if (y-d/2 <= 0) {
      ySpeed = abs(ySpeed);
      sound.play();
    }
  }
  void playerCol(Player p1, SoundFile sound) {
    if(x - r <= p1.x + int(p1.w/2) && x + r >= p1.x - int(p1.w/2) && y -r <= p1.y + int(p1.h/2) && y + r >= p1.y - int(p1.h/2)){
      if(y + r <= p1.y){
        xSpeed = map((x-p1.x),-p1.w/2,p1.w/2,-(actualSpeed*8/10),(actualSpeed*8/10));
        ySpeed = -sqrt((actualSpeed*actualSpeed)-(xSpeed*xSpeed));
        sound.play();
      } else if(y - r >= p1.y - p1.h/2){
        ySpeed = abs(ySpeed);
        sound.play();
      } else if(x < p1.x){
        xSpeed = -abs(xSpeed);
        sound.play();
      } else if(x > p1.x){
        xSpeed = abs(xSpeed);
        sound.play();
      }
    }
  }
  void brickCol(Brick b1, SoundFile sound){
    if(x - r <= b1.x + int(b1.w/2) && x + r >= b1.x - int(b1.w/2) && y - r <= b1.y + int(b1.h/2) && y + r >= b1.y - int(b1.h/2)){
      if(y + r <= b1.y){
        ySpeed = -abs(ySpeed);
        sound.play();
      } else if(y - r >= b1.y){
        ySpeed = abs(ySpeed);
        sound.play();
      }
       if(x + r <= b1.x - 5*b1.w/10){
        xSpeed = -abs(xSpeed);
        sound.play();
      } else if(x - r >= b1.x + 5*b1.w/10){
        xSpeed = abs(xSpeed);
        sound.play();
      }
      b1.animation.isAnimating = true;
      b1.brickExists = false;
    }
  }
}
