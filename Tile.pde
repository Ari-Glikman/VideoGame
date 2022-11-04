final float WIDTH = 0.05;
final int ROWS = 20;
final int COLS = 30;
final float MAX_HEIGHT = 0.15;
public class Tile {
  color c;
  float h; //height


  Tile() {
    c = color(random(0, 255), random(0, 255), random(0, 255));
    h = random(0, MAX_HEIGHT);
  }

  void makeTile() { //centered at 0,0. width,height = 0.1

    pushMatrix();

    if (perspective) {
      translate(0, 0, this.h);  // make it the top
    }

    //println(z);
    if (doTextures) {
      pushMatrix();
      beginShape(TRIANGLES);
      texture(spritesGround[1]);
      vertex(-WIDTH, WIDTH, 0, 1); 
      vertex(-WIDTH, -WIDTH, 0, 0); 
      vertex(WIDTH, WIDTH, 1, 1); 

      vertex(-WIDTH, -WIDTH, 0, 0);  
      vertex(WIDTH, -WIDTH, 1, 0);  
      vertex(WIDTH, WIDTH, 1, 1); 

      endShape();
      popMatrix();
    } else {
      beginShape(TRIANGLES);


      vertex(-WIDTH, WIDTH); 
      vertex(-WIDTH, -WIDTH); 
      vertex(WIDTH, WIDTH); 

      vertex(-WIDTH, -WIDTH); 
      vertex(WIDTH, -WIDTH);  
      vertex(WIDTH, WIDTH); 

      endShape();
    }
    popMatrix();

    if (perspective || !perspective) {
      pushMatrix();
      pushMatrix();
      translate(0, -.1, 0); //front side
      makeSide();
      popMatrix();

      pushMatrix(); //right side
      rotateZ(-PI/2);
      makeSide();
      popMatrix();

      pushMatrix();    //left side
      rotateZ(PI/2);
      makeSide();
      popMatrix();

      pushMatrix();
      makeSide();  //backside
      popMatrix();

      popMatrix();
    }
  }

  void makeSide() {
    pushMatrix();
    translate(0, WIDTH, 0); //reduce z fighting, push back a little
    rotateX(PI/2);
    if (doTextures) {
      pushMatrix();
      //rotateX(PI);
      //image(spritesGround[0], -WIDTH, 0, WIDTH*2, this.h);
      beginShape(TRIANGLES);
      texture(spritesGround[0]);
      vertex(-WIDTH, this.h, 0, 1); //top left
      vertex(-WIDTH, -WIDTH, 0, 0); //bottom left
      vertex(WIDTH, this.h, 1, 1); // top right

      vertex(-WIDTH, -WIDTH, 0, 0);  //bottom left
      vertex(WIDTH, -WIDTH, 1, 0);  // bottom right
      vertex(WIDTH, this.h, 1, 1); // top right

      endShape();
      popMatrix();
    } else {
      beginShape(TRIANGLES);

      vertex(-WIDTH, this.h); //top left
      vertex(-WIDTH, -WIDTH); //bottom left
      vertex(WIDTH, this.h); // top right

      vertex(-WIDTH, -WIDTH);  //bottom left
      vertex(WIDTH, -WIDTH);  // bottom right
      vertex(WIDTH, this.h); // top right

      endShape();
    }
    popMatrix();
  }
}
