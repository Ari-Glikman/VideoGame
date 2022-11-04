boolean moveRight = false;
boolean moveLeft = false;
boolean moveUp = false;
boolean moveDown = false;
boolean reset = false;
final float SCROLL_SPEED = 0.01;
final int OFFSET_ONE = ROWS/10;
final int OFFSET_TWO = 2*OFFSET_ONE;
float scroll1 = 0;
float scroll2 = 0;
float worldz = -1;
float height1 = 2;

public class World
{
  WorldSection offScreen;
  WorldSection part1 = new WorldSection();
  WorldSection part2 = new WorldSection();
  WorldSection part3 = new WorldSection();
  World() {
    pl.addParticle(myPlayer, new PVector(0, 0), 0); //main player
  } 
  void makeWorld() {
    scroll1+=SCROLL_SPEED;
    scroll2+=SCROLL_SPEED;
    if (scroll1%OFFSET_ONE >=OFFSET_ONE-SCROLL_SPEED) {
      scroll1 = -OFFSET_ONE;
    }
    if (scroll2%OFFSET_TWO>=OFFSET_TWO-SCROLL_SPEED)
    {
      scroll2 = 0;
      pl.addParticle(new Enemy(), new PVector(0.6, 0.6), 2); //make a new enemy
    }

    pushMatrix();
    translate(0, 0, worldz);
    if (perspective) {
      translate(0, 2, -3);

      rotateX(-PI/6);
      scale(5);
    }

    pushMatrix();
    translate(-0.5, -scroll1); //0.5 since first column starts at bottom left corner but need to move over to center camera
    part1.makeSection();
    popMatrix();    


    pushMatrix();
    translate(-0.5, -scroll2);
    translate(0, OFFSET_ONE);
    part2.makeSection();
    popMatrix();
    pushMatrix();
    for (int i = pl.particles.size()-1; i >= 0; i--) {
      pushMatrix();
      Particle p = pl.particles.get(i);
      p.setup();
      p.update();
      p.display();
      p.collide();
      if (p.isDead) {
        if (p.type ==0 || p.type ==2 && doBonus) {
          explode(p.position, p.type);
        }
        pl.particles.remove(i);
      }
      popMatrix();
    }
    popMatrix();
    popMatrix();

  }
}

void explode(PVector pos, int type) {
  if (type ==0) { //player
    for (int i = 0; i< 1000; i++)
      pl.addParticle(new ExplosionBit(pos), new PVector(pos.x, pos.y+0.01, pos.z), 4); //have a bit of an offset so particles are more noticeably spread out = better effect
  } else//enemy
  {
    for (int i = 0; i< 100; i++)
      pl.addParticle(new ExplosionBit(pos), new PVector(pos.x, pos.y+0.01, pos.z), 4);
  }
}
