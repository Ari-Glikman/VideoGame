public class Enemy extends Particle {
  float[] currentFrame;
  float[] nextFrame;
  int currentKeyframe = 0;
  final int RESTART = -1;
  int steps = RESTART;
  final float pixelsPerUnit = max(width, height)/2; //screen is 2x2 -> pixels/2units = pixels/unit
  final float speed = 2; // movementSpeed or pixels per step
  int currentStep = 0;
  int frame = 0;
  float[][] keyframes = {
    {random(-1, 1), random(-.4, 2)}, // X, Y
    {random(-1, 1), random(-.4, 2)}, 
    {random(-1, 1), random(-.4, 2)}, 
    {random(-1, 1), random(-.4, 2)}
  };
  float x = 0;
  float y = 0;
  int shootFrame;
  PVector enemyPos;
  Enemy() {

    shootFrame = int(random(1, 3));
  }
  void update() {
    if (currentKeyframe!=shootFrame) {
      if ( steps == RESTART )
        steps = calculateSteps(currentFrame, nextFrame);
      float t = currentStep/(float)steps;
      float t_ = (t + (1-cos(t*PI))/2) /2; //leveled in easing in/out 
      currentStep++;


      if (currentStep >= steps) {  // advance keyframe
        currentKeyframe = (currentKeyframe+1)%keyframes.length;
        currentStep = 0;
        steps = RESTART;
      }
      position.x = lerp(currentFrame[0], nextFrame[0], t_); 
      position.y = lerp(currentFrame[1], nextFrame[1], t_);
    } else {//shoot
      pl.addParticle(new Bullet(1, position), new PVector(position.x, position.y), 3);
      //second bullet with a bit of offset
      pl.addParticle(new Bullet(1, new PVector(position.x, position.y+0.05)), new PVector(position.x, position.y), 3);
      shootFrame = abs(shootFrame-1)%4;
    }
  }
  void display() {


    translate(position.x, position.y);

    if (doTextures) {
      pushMatrix();
      if (perspective)
        rotateX(PI/4);
      rotateZ(PI);  

      beginShape(TRIANGLES);
      texture(spritesEnemy[frame]);
      vertex(-TRI_SIZE, -TRI_SIZE, 0, 0); 
      vertex(TRI_SIZE, -TRI_SIZE, 1, 0); 
      vertex(-TRI_SIZE, TRI_SIZE, 0, 1); 

      vertex(-TRI_SIZE, +TRI_SIZE, 0, 1);  
      vertex(TRI_SIZE, +TRI_SIZE, 1, 1);  
      vertex(TRI_SIZE, -TRI_SIZE, 1, 0); 

      endShape();


      if (currentStep>((frame*steps)/9)) //slow down sprites/frame changes a bit
        frame = (frame + 1) % spritesEnemy.length;
      popMatrix();
    } else {
      fill(0, 1, 0);
      beginShape(TRIANGLES);
      vertex(-TRI_SIZE, -TRI_SIZE);
      vertex(+TRI_SIZE, -TRI_SIZE);
      vertex(-TRI_SIZE, +TRI_SIZE);

      vertex(-TRI_SIZE, +TRI_SIZE);
      vertex(+TRI_SIZE, +TRI_SIZE);
      vertex(+TRI_SIZE, -TRI_SIZE);

      endShape();
    }
  }
  void setup() {
    enemyPos = position;
    currentFrame = keyframes[currentKeyframe];
    nextFrame = keyframes[(currentKeyframe+1)%keyframes.length];
    if (perspective) { //same place as ship
      translate(0, -0.5, +0.18); //put in frustum, move down a bit to keep around center screen, raise above the towers so does not collide when rotating
      scale(0.4);
    }
  }
  void collide() {
    if (doCollision) {
      for (int i = pl.particles.size()-1; i >= 0; i--) {

        Particle p = pl.particles.get(i);
        if (abs(p.position.x - enemyPos.x) <TRI_SIZE&& abs(p.position.y-enemyPos.y)<TRI_SIZE && p.type!=2 && p.type!=3 && p.type!=4) {
          p.isDead = true;
          isDead = true;

          float rand = random(0, 1);
          if (rand> 0.25)
            pl.addParticle(new Enemy(), new PVector(0.6, 0.6), 2);
        }
      }
    }
  }

  int calculateSteps(float[] current, float[] next) { //how many steps in the next frame needed, as was shown in class
    float distance = sqrt(sq(current[0]-next[0])+sq(current[1]-next[1]));
    return (int)(distance * pixelsPerUnit / speed);
  }
}
