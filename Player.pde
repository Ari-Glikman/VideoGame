boolean goHome = false;
final float TRI_SIZE = 0.1; //half triangle side length
final float PLAYER_Z = -1.1;
float verticalMoveRotAngle = 0;
float horizontalMoveRotAngle = 0;
boolean playerShoot = false;
public class Player extends Particle {
  PVector playerPos;
  int type = 1;
  void update() {
    if (moveUp) {
      position.y +=0.01;
      verticalMoveRotAngle -=0.01;
    } else if (!moveUp) {
      if (verticalMoveRotAngle<0)
        verticalMoveRotAngle +=0.01;
    }
    if (moveDown) {
      position.y -= 0.01;
      verticalMoveRotAngle +=0.01;
    } else if (!moveDown) {
      if (verticalMoveRotAngle>0)
        verticalMoveRotAngle -=0.01;
    }
    if (moveLeft) {
      position.x -=0.01;
      horizontalMoveRotAngle -=0.01;
    } else if (!moveLeft) {
      if (horizontalMoveRotAngle<0) {
        horizontalMoveRotAngle +=0.01;
      }
    }

    if (moveRight) {
      position.x += 0.01;
      horizontalMoveRotAngle +=0.01;
    } else if (!moveRight) {
      if (horizontalMoveRotAngle>0) {
        horizontalMoveRotAngle -=0.01;
      }
    }

    if (goHome) { //center of screen (0,-.25)
      if (position.x>0.01) {
        position.x-=0.003;
      } else if (position.x<-0.01) {
        position.x+=0.003;
      }
      if (position.y>-.5) {
        position.y-=0.003;
      } else if (position.y<-.5) {
        position.y+=0.003;
      }
    }



    horizontalMoveRotAngle = constrain(horizontalMoveRotAngle, -PI/8, PI/8);

    verticalMoveRotAngle = constrain(verticalMoveRotAngle, -PI/12, PI/12);
    if (perspective) {
      position.x = constrain(position.x, -.6*(position.y+1), .6*(position.y+1)); //can go more outwards as it goes up
      position.y = constrain(position.y, -.6, 1);
    } else {
      position.x = constrain(position.x, -.85, .85);
      position.y = constrain(position.y, -.8, .8);
    }
  }
  void setup() {
    playerPos = position;
    pushMatrix();
    if (playerShoot) {

      Bullet bullet = new Bullet(0, position);
      pl.addParticle(bullet, new PVector(position.x, position.y), 1);
      playerShoot = false;
    }
    popMatrix();
  }
  void display() {
    pushMatrix();

    if (perspective) {
      translate(0, -0.5, +0.15); //put in frustum, move down a bit to keep around center screen, raise above the towers so does not collide when rotating
      scale(0.4);
    }

    translate(position.x, position.y);
    rotateX(verticalMoveRotAngle);
    rotateY(horizontalMoveRotAngle);
    translate(0, 0, TRI_SIZE);  //raise above towers to avoid collisions when rotating
    fill(1, 0, 0);

    if (doTextures) {
      pushMatrix();
      rotateZ(PI);
      //image(spritesPlane[0], -TRI_SIZE, -TRI_SIZE, TRI_SIZE*2, TRI_SIZE*2);
      beginShape(TRIANGLES);
      texture(spritesPlane[0]);
      vertex(-TRI_SIZE, -TRI_SIZE, 0, 0); //top left
      vertex(TRI_SIZE, -TRI_SIZE, 1, 0); //bottom left
      vertex(-TRI_SIZE, TRI_SIZE, 0, 1); // top right

      vertex(-TRI_SIZE, +TRI_SIZE, 0, 1);  //bottom left
      vertex(TRI_SIZE, +TRI_SIZE, 1, 1);  // bottom right
      vertex(TRI_SIZE, -TRI_SIZE, 1, 0); // top right

      endShape();
      popMatrix();
    } else {
      beginShape(TRIANGLES);
      vertex(-TRI_SIZE, -TRI_SIZE);
      vertex(+TRI_SIZE, -TRI_SIZE);
      vertex(-TRI_SIZE, +TRI_SIZE);

      vertex(-TRI_SIZE, +TRI_SIZE);
      vertex(+TRI_SIZE, +TRI_SIZE);
      vertex(+TRI_SIZE, -TRI_SIZE);


      endShape();
    }
    popMatrix();
  }
  void collide() {
    if (doCollision) {
      for (int i = pl.particles.size()-1; i >= 0; i--) {

        Particle p = pl.particles.get(i);


        if (abs(p.position.x - playerPos.x) <TRI_SIZE&& abs(p.position.y-playerPos.y)<TRI_SIZE && p.type!=0 && p.type!=1 && p.type!=4) {      

          pl.particles.remove(i);
          p.isDead = true;

          isDead = true;
        }
      }
    }
  }
}
