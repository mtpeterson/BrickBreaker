import processing.sound.*;

SoundFile pop;
SoundFile music;

Player p1;
Ball b1;

boolean moveL;
boolean moveR;
boolean ballExists;

int heightGap;
int rowGap;

int state;

Row[] lvl1Wall = new Row[8];
Row[] lvl2Wall = new Row[7];

PImage stars;

PImage[] leftFlameImages = new PImage[2];
Animation leftFlameAnimation;

PImage[] rightFlameImages = new PImage[2];
Animation rightFlameAnimation;

boolean rFlameAnimate;
boolean lFlameAnimate;

PImage staticPlayer;

PImage[] brickBreakingImages = new PImage[9];
Animation brickBreaking;


void setup() {
  size(1200, 800);
  p1 = new Player();

  pop = new SoundFile(this, "pop.wav");
  music = new SoundFile(this, "Dawn Sunrise.mp3");
  music.amp(.1);
  //pop amp doesn't turn it up at all
  music.play();

  rectMode(CENTER);
  textAlign(CENTER);
  imageMode(CENTER);

  moveL = false;
  moveR = false;

  heightGap = 80;
  rowGap = 5;

  state = 0;

  for (int i = 0; i<leftFlameImages.length; i++) {
    leftFlameImages[i] = loadImage("LFlame" + str(i) + ".png");
  }
  leftFlameAnimation = new Animation(leftFlameImages, 0.2, 1);

  for (int i = 0; i<rightFlameImages.length; i++) {
    rightFlameImages[i] = loadImage("RFlame" + str(i) + ".png");
  }
  rightFlameAnimation = new Animation(rightFlameImages, 0.2, 1);

  rFlameAnimate = false;
  lFlameAnimate = false;

  staticPlayer = loadImage("Static Player.png");

  stars = loadImage("starry skyy.png");
  stars.resize(width, height);

  //level 1//////////////////////
  lvl1Wall[0] = new Row(100, 6);
  lvl1Wall[1] = new Row(150, 7);
  lvl1Wall[2] = new Row(200, 6);
  lvl1Wall[3] = new Row(250, 5);
  lvl1Wall[4] = new Row(300, 4);
  lvl1Wall[5] = new Row(350, 3);
  lvl1Wall[6] = new Row(400, 2);
  lvl1Wall[7] = new Row(450, 1);
  ///////////////////////////////

  //level 2//////////////////////
  lvl2Wall[0] = new Row(100, 8);
  lvl2Wall[1] = new Row(150, 7);
  lvl2Wall[2] = new Row(200, 6);
  lvl2Wall[3] = new Row(250, 5);
  lvl2Wall[4] = new Row(300, 6);
  lvl2Wall[5] = new Row(350, 7);
  lvl2Wall[6] = new Row(400, 8);
  //////////////////////////////
}

void draw() {
  switch(state) {
  case 0:
    endScreen("Press r to start", width/2, height/2, color(255));
    break;
  case 1:
    level1();
    break;
  case 2:
    level2();
    break;
  case 3:
    state = 10;
    break;
    //case 2:
    //  winSet();
    //  winScreen(winText, 90, 300, winColor);
    //  break;
    //case 3:
    //  winSet();
    //  winScreen(winText, 90, 300, winColor);
    //  break;
  case 9:
    //endScreen("One more try?", width/2, height/2, color(255));
    background(stars);
    fill(color(255));
    textSize(100);
    text("One more try?", width/2, height/2 - 50);
    text("Press r to continue", width/2, height/2 + 50);
    break;
  case 10:
    //endScreen("You won!!!", width/2, height/2, color(255));
    background(stars);
    fill(color(255));
    textSize(100);
    text("You won!!!", width/2, height/2 - 50);
    text("Press g to restart", width/2, height/2 + 50);
    break;
  }

  if (music.isPlaying() == false) {
    music.play();
  }
}

void level2() {
  background(stars);
  for (int i = 0; i < lvl2Wall.length; i++) {
    lvl2Wall[i].render(ballExists, b1);
  }
  if (moveL == true) {
    p1.moveL();
  }
  if (moveR == true) {
    p1.moveR();
  }
  if (rFlameAnimate == true) {
    rightFlameAnimation.isAnimating = true;
    rightFlameAnimation.display(p1.x, p1.y);
  }
  if (lFlameAnimate == true) {
    leftFlameAnimation.isAnimating = true;
    leftFlameAnimation.display(p1.x, p1.y);
  }
  image(staticPlayer, p1.x, p1.y, staticPlayer.width, staticPlayer.height);
  if (ballExists == true) {
    b1.render();
    b1.move();
    b1.wallDetect(pop);
    b1.playerCol(p1, pop);
  }
}

void level1() {
  background(stars);
  for (int i = 0; i < lvl1Wall.length; i++) {
    lvl1Wall[i].render(ballExists, b1);
  }
  if (moveL == true) {
    p1.moveL();
  }
  if (moveR == true) {
    p1.moveR();
  }
  if (rFlameAnimate == true) {
    rightFlameAnimation.isAnimating = true;
    rightFlameAnimation.display(p1.x, p1.y);
  }
  if (lFlameAnimate == true) {
    leftFlameAnimation.isAnimating = true;
    leftFlameAnimation.display(p1.x, p1.y);
  }
  image(staticPlayer, p1.x, p1.y, staticPlayer.width, staticPlayer.height);
  if (ballExists == true) {
    b1.render();
    b1.move();
    b1.wallDetect(pop);
    b1.playerCol(p1, pop);
  }
  lvl1WinDetect();
}

void keyPressed() {
  if (key == 'r') {
    state = 1 ;
  }
  if (key == 'a') {
    moveL = true;
    rFlameAnimate = true;
  }
  if (key == 'd') {
    moveR = true;
    lFlameAnimate = true;
  }
  if (key == ' ') {
    b1 = new Ball();
    ballExists = true;
  }
  if (key == 't') {
    state ++;
  }
  if ( key == 'g') {
    state = 1;
    music.stop();
    music.play();
    ballExists = false;
    p1.x = width/2;
    
    //level 1//////////////////////
    lvl1Wall[0] = new Row(100, 6);
    lvl1Wall[1] = new Row(150, 7);
    lvl1Wall[2] = new Row(200, 6);
    lvl1Wall[3] = new Row(250, 5);
    lvl1Wall[4] = new Row(300, 4);
    lvl1Wall[5] = new Row(350, 3);
    lvl1Wall[6] = new Row(400, 2);
    lvl1Wall[7] = new Row(450, 1);
    ///////////////////////////////

    //level 2//////////////////////
    lvl2Wall[0] = new Row(100, 8);
    lvl2Wall[1] = new Row(150, 7);
    lvl2Wall[2] = new Row(200, 6);
    lvl2Wall[3] = new Row(250, 5);
    lvl2Wall[4] = new Row(300, 6);
    lvl2Wall[5] = new Row(350, 7);
    lvl2Wall[6] = new Row(400, 8);
    //////////////////////////////
  }
}
///////////////////////////////////////////////////////////////////////////////////
void keyReleased() {
  if (key == 'a') {
    moveL = false;
    rFlameAnimate = false;
  }
  if (key == 'd') {
    moveR = false;
    lFlameAnimate = false;
  }
}

boolean lvl1Pass() {
  for (int i = 0; i < lvl1Wall.length; i++) {
    lvl1Wall[i].render(ballExists, b1);

    for (Brick aBrick : lvl1Wall[i].brickList) {
      if (aBrick.brickExists == true) {
        return false;
      }
    }
  }
  return true;
}

boolean lvl2Pass() {
  for (int i = 0; i < lvl2Wall.length; i++) {
    lvl2Wall[i].render(ballExists, b1);

    for (Brick aBrick : lvl2Wall[i].brickList) {
      if (aBrick.brickExists == true) {
        return false;
      }
    }
  }
  return true;
}

void endScreen(String endText, int x, int y, color aColor) {
  background(stars);
  fill(aColor);
  textSize(100);
  text(endText, x, y);
}

void lvl1WinDetect() {
  if (lvl1Pass() == true) {
    state = 2;
    ballExists = false;
  }
}

void lvl2WinDetect() {
  if (lvl2Pass() == true) {
    state = 3;
    ballExists = false;
  }
}
