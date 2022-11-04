final float BIT_SIZE = 0.01;

public class ExplosionBit extends Particle {
  PVector velocity;
  PVector acceleration;

  ExplosionBit(PVector position) {
    type = 4;
    this.position = position;
    velocity = new PVector(random(-0.002, 0.002), random(-0.002, 0.002), random(0, 0.2)); 
    acceleration = new PVector(0, 0, -0.02); //gravity pulls particle down
    lifespan = 200;
  }

  void display() {
    translate(position.x, position.y, TRI_SIZE);
    if (doTextures) {
      pushMatrix();
      rotateZ(PI);
      beginShape(TRIANGLES);
      texture(spritesBullet[0]);
      vertex(-BIT_SIZE, BIT_SIZE, 0, 1);
      vertex(BIT_SIZE, -BIT_SIZE, 1, 0); 
      vertex(0, BIT_SIZE, 0.5, 1); 
      endShape();


      popMatrix();
    } else {
      pushMatrix();
      fill(0, 0, 0);

      beginShape(TRIANGLES);
      vertex(-0.01, -0.01);
      vertex(0.01, -0.01);
      vertex(0, 0.01);
      endShape();

      popMatrix();
    }
  }

  void setup() {
    if (perspective) { //same place as player/enemy
      translate(0, -0.5, +0.14); //put in frustum, move down a bit to keep around center screen, raise above the towers so does not collide when rotating
      scale(0.4);
    }
  }

  void collide() {
  }

  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    lifespan--;
    if (lifespan<0)
      isDead = true;
  }
}
