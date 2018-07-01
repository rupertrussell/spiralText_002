// Draws an offset grid of tiled circles
// Rupert Russell 1 July 2018
// loades an image from data and tiles it

PImage tile;  //  Create  variable to hold the tile

int numberOfColumns = 8;
int hightOfColumn = 6  ;
 


int widthOfTile = 1069;
int hightOfTile = 1121;
float offset = widthOfTile * 0.8;  //

void setup() {
  size(8000, 8000);
  noLoop();
  background(0);
}

void draw() {
  tile = loadImage("tile.png");
  for (int n=0; n < numberOfColumns; n++) {
    // Odd numbers columns
    if (n % 2 != 0) { 
      pushMatrix();
      translate(n * offset, hightOfTile);
      drawColumn();
      popMatrix();
      println("n = " + n + " is odd");
    } else { 
      // even numberd columns
      println("n = " + n + " is even");
      pushMatrix();
      translate(n * offset, hightOfTile/2);
      drawColumn();
      popMatrix();
    }
  }
  println("SAVING");
  save("test004.png");
  println("EXIT");
  exit();
}

void drawColumn() {
  // draw a column
  int i = 0;
  for (int j = 0; j < hightOfColumn; j ++) {  
    image(tile, i, j * hightOfTile);
  }
}
