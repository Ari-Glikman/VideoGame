final char KEY_VIEW = 'r';

final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';

final char KEY_BONUS = 'b';
final char KEY_TEX = 't';
final char KEY_COLLISION = 'c';

boolean doBonus = false;
boolean doTextures = false;
boolean doCollision = false;
boolean perspective = false;

void keyPressed()
{
  if (key == KEY_VIEW) {
    perspective = !perspective;
  }
  if (key == KEY_COLLISION)
    doCollision = !doCollision;

  if (key == KEY_UP) {
    moveUp = true;
    goHome = false; //send player to home position
  }
  if (key == KEY_DOWN) {
    moveDown = true;
    goHome = false;
  }
  if (key == KEY_RIGHT) {
    moveRight = true;
    goHome = false;
  }
  if (key == KEY_LEFT) {
    moveLeft = true;
    goHome = false;
  }
  if (key == KEY_SHOOT) {
    playerShoot = true;
  }

  if (key == KEY_TEX) {
    doTextures = !doTextures;
  }
  
  //activate bonuses
  //could only get the lerp change going from ortho to perspective but not vice versa.
  //activate explosions when player or enemy dies
  if (key == KEY_BONUS) {  
    doBonus = !doBonus;
  }
}

void keyReleased() {
  if (!keyPressed) {
    goHome = true;
  }
  if (key ==KEY_UP)
    moveUp = false;

  if (key ==KEY_DOWN)
    moveDown = false;

  if (key ==KEY_RIGHT)
    moveRight =false;

  if (key == KEY_LEFT)
    moveLeft = false;

  if (key == KEY_SHOOT) {
    playerShoot = false;
  }
}
