//COMP 3490 ASSIGNMENT 3 
//BY ARIEL GLIKMAN 7806386
//Everything was completed except part of the bonus (lerping from perspective to ortho (could not get it working for some reason)) - but lerping from ortho to perspective works
// all other parts were completed as instructed
// to turn on 'bonus' features press bonus key as noted in Modes tab


PImage[] spritesPlane = new PImage[1]; 
//https://opengameart.org/content/64-x-64-animated-plane

PImage[] spritesGround = new PImage[2];
// grass: https://opengameart.org/content/grass-tile-0
// wood tile: https://opengameart.org/content/pixel-platformer-tile-set


PImage[] spritesBullet = new PImage[1];
// fire: https://opengameart.org/content/camp-fire-animation-for-rpgs-finished Credit goes to Zabin and Jetrel from OGA

PImage[] spritesEnemy = new PImage[10];
// https://lionheart963.itch.io/wizard

PVector cameraPos = new PVector(0, 0, 0);
PVector lookAtPoint = new PVector (0, 0, 0);
PVector lookAtVec = new PVector (0, 0, 0);
PVector roughUp = new PVector(0, 0, 0);

Player myPlayer = new Player();
ParticleList pl = new ParticleList();
World myWorld1 = new World();
boolean doSwitchPer = false;
boolean doSwitchOrtho = false;
int i = 0; //do switch per lerp constant
int j = 0; //do switch ortho lerp constant

//for matrix elements when lerping between proj. views
float x = 0;
float y = 0;
float w = 0; 
float z = 0; 

void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // uses normalized 0..1 texture coords
  textureWrap(REPEAT);
  noStroke();
  background(0);
  resetMatrix();

  setupPOGL(); // setup our hack to ProcesingOpenGL to let us modify the projection matrix manually
  spritesPlane[0] = loadImage("l0_Plane1.png");
  spritesGround[0] = loadImage("base.png");
  spritesGround[1] = loadImage("grass_tile.png");
  spritesBullet[0] = loadImage("fire.png");
  for (int i = 0; i <spritesEnemy.length; i++) {
    spritesEnemy[i]= loadImage("frame"+(i+1)+".png");
  }
  setupCamera();
}



void draw() {
  clear();
  resetMatrix();
  if (!perspective) {
    doSwitchPer = true;

    if (doSwitchOrtho && doBonus) { //could only get bonus switching working from perspective to orthographic and not vice versa :(
      doSwitch();
      if (j <120)
      {
        j++;
      } else {
        doSwitchOrtho = false;
        j = 0;
      }
    } else {
      ortho(-1, 1, 1, -1, -1, 1);
    }
  } else if (perspective) {
    doSwitchOrtho = true;
    if (doSwitchPer && doBonus) {
      w = lerp(-1, -1.0513, i/120.0);  //values taken from ortho/perspective matrix elements. lerp between the ones that change.
      x = lerp(-2, -2.0513, i/120.0);
      y = lerp(-.1, -1, i/120.0);
      z = lerp(3, 0, i/120.0);

      PMatrix3D inBetween = new PMatrix3D(
        1, 0, 0, 0, 
        0, 1, 0, 0, 
        0, 0, w, x, 
        0, 0, y, z
        );

      setProjection(inBetween);
      if (i <120)
      {
        i++;
      } else {
        doSwitchPer = false;
        i = 0; 
      }
    } else {
      frustum(-1, 1, -1, 1, 1, 40);
      fixFrustumYFlip();
    }
  }

  setupCamera();
  camera(cameraPos.x, cameraPos.y, cameraPos.z, lookAtPoint.x, lookAtPoint.y, lookAtPoint.z, roughUp.x, roughUp.y, roughUp.z);
  myWorld1.makeWorld();
}

void setupCamera() {
  cameraPos.x = 0;
  cameraPos.y = 0;
  cameraPos.z = 0;

  lookAtPoint.x = 0;
  lookAtPoint.y = 0;
  lookAtPoint.z = -1;
  lookAtPoint.normalize();

  roughUp.x = 0;
  roughUp.y = 1;
  roughUp.z = 0;
  roughUp.normalize();
}

void doSwitch() {
  w = -1;
  x = 0;
  y = 0;
  z= 1;
  PMatrix3D inBetween = new PMatrix3D(
    1, 0, 0, 0, 
    0, 1, 0, 0, 
    0, 0, w, x, 
    0, 0, y, z
    );

  setProjection(inBetween);
}
