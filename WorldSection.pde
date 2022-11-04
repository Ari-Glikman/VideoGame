public class WorldSection 
{
  Tile[][] myTiles = new Tile[ROWS][COLS];
  color[][] tilecolours;
  WorldSection() {

    myTiles = this.getTiles();
  }

  Tile[][] getTiles() {
    Tile[][] someTiles = new Tile[ROWS][COLS];
    for (int i = 0; i<ROWS; i++) {
      for (int j = 0; j<COLS; j++) {
        someTiles[i][j] = new Tile();
      }
    }
    return someTiles;
  }

  void makeLine(int line) {
    pushMatrix();
    translate(-(1-WIDTH), -(1-WIDTH));
    
    fill(myTiles[line][0].c);
    
    myTiles[line][0].makeTile();
    
    for (int i = 0; i < COLS-1; i++) {
      fill(myTiles[line][i+1].c);
      translate(2*WIDTH, 0);
      myTiles[line][i+1].makeTile();
    }
    popMatrix();
  }
  void makeSection() {
    pushMatrix();
    for (int i =0; i<ROWS; i++) {
      makeLine(i);
      translate(0, 2*WIDTH);
    }
    popMatrix();
  }
}
