float BULLET_SIZE = 0.03;

public class Bullet extends Particle {
  PVector velocity;
  PVector acceleration;
  PVector bulletPos;
  float rot = 0;
  Bullet(int owner, PVector p) {
    if (owner == 0) { //player owner
      velocity = new PVector(0, .01);
      acceleration = new PVector(0, 0);
    }
    if (owner==1) { //enemy owner
      acceleration = new PVector(0, 0);
      velocity = new PVector(myPlayer.position.x - p.x, myPlayer.position.y - p.y);
      velocity.x*=0.01;
      velocity.y*=0.01;
    }
    lifespan = 300;
  }
  float lifespan;
  void update() {
    position.add(velocity);
    velocity.add(acceleration);

    lifespan--;
  }
  void setup() {
    //println(owner);
    bulletPos = position;
    if (perspective) { //same place as ship
      translate(0, -0.5, +0.14); //put in frustum, move down a bit to keep around center screen, raise above the towers so does not collide when rotating
      scale(0.4);
    }
  }
  void display() {
    fill(0, 0, 0);
    pushMatrix();
    translate(position.x, position.y, TRI_SIZE);

    rot+=0.04;

    rotateZ(rot);


    if (doTextures) {
      pushMatrix();
      rotateZ(PI);
      //image(spritesBullet[0], -BULLET_SIZE, -BULLET_SIZE, BULLET_SIZE*2, BULLET_SIZE*2);
      beginShape(TRIANGLES);
      texture(spritesBullet[0]);
      vertex(-BULLET_SIZE, -BULLET_SIZE, 0, 0); //top left
      vertex(-BULLET_SIZE, BULLET_SIZE, 0, 1); //bottom left
      vertex(BULLET_SIZE, -BULLET_SIZE, 1, 0); // top right

      vertex(-BULLET_SIZE, +BULLET_SIZE, 0, 1); //top left
      vertex(BULLET_SIZE, BULLET_SIZE, 1, 1); //bottom left
      vertex(BULLET_SIZE, -BULLET_SIZE, 1, 0); // top right


      //vertex(BULLET_SIZE, BULLET_SIZE, 1,1);
      endShape();


      popMatrix();
    } else {
      beginShape(TRIANGLES);
      vertex(-BULLET_SIZE, -BULLET_SIZE);
      vertex(0, +BULLET_SIZE);
      vertex(+BULLET_SIZE, -BULLET_SIZE);
      endShape();
    }
    popMatrix();
  }
  void collide() {
    if (lifespan < 0.0) {
      isDead = true;
    } else if (doCollision) {
      for (int i = pl.particles.size()-1; i >= 0; i--) {

        Particle p = pl.particles.get(i);

        if (p.type!=type && abs(p.position.x - bulletPos.x) <BULLET_SIZE&& abs(p.position.y-bulletPos.y)<BULLET_SIZE && p.type!=0 && p.type!=2 && p.type!=4) {

          //pl.particles.remove(i);
          p.isDead = true;
          isDead = true;
        }   
        //return true;
      }
    }
  }
}
