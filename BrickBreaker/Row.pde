class Row {
  int y;
  int numBricks;
  int brickGap;
  int brickW;
  int brickH;

  ArrayList<Brick> brickList;

  color fillC;
  
  boolean dead;

  Row(int yPos, int num) {
    y = yPos;
    numBricks = num;

    brickGap = 6;

    brickW = 100;
    brickH = 40;

    brickList = new ArrayList<Brick>();
    
    if (num %2 == 0) {
      for (int i = 1; i <= numBricks/2; i++) {
        int plusX = width/2 + i * (brickW + brickGap) - (brickW + brickGap)/2;
        brickList.add(new Brick(plusX, y, brickW, brickH));
        int minusX = width /2 - i * (brickW + brickGap) + (brickW + brickGap)/2;
        brickList.add(new Brick(minusX, y, brickW, brickH));
      }
    } else {
      brickList.add(new Brick(width/2, y, brickW, brickH));
      for (int i = 1; i <= (numBricks - 1)/2; i++) {
        int plusX = width/2 + i * (brickW + brickGap);
        brickList.add(new Brick(plusX, y, brickW, brickH));
        int minusX = width/2 - i * (brickW + brickGap);
        brickList.add(new Brick(minusX, y, brickW, brickH));
      }
    }
  }

  void render(boolean ballE, Ball ball1) {
    for (Brick aBrick : brickList) {
      if (aBrick.brickExists == true) {
        if (ballE == true) {
          ball1.brickCol(aBrick, pop);
        }
      }
      aBrick.render();
    }
  }
}
