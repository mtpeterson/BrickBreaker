class Brick {
  int x;
  int y;
  int w;
  int h;
  color fillC;
  boolean brickExists;
  Animation animation;

  Brick(int x1, int y1, int w1, int h1) {
    x = x1;
    y = y1;
    w = w1;
    h = h1;
    fillC = color(0, 255, 255);
    brickExists = true;
    rectMode(CENTER);
    
    PImage[] images = new PImage[9];

    for (int i = 0; i<images.length; i++) {
      images[i] = loadImage("BrickBreaking" + str(i) + ".png");
    }
    animation = new Animation(images, 0.2, 1);
  }

  void render() {
    if (brickExists == true) {
      animation.display(x, y);
    } else if (animation.isAnimating == true) {
      animation.display(x, y);
    }
  }
}
