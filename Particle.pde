abstract class Particle {
  PVector position;
  int lifespan;
  int type;
  boolean isDead;
  public abstract void update();
  public abstract void setup();
  public abstract void display();
  public abstract void collide();

}

public class ParticleList extends Particle {

  ArrayList<Particle> particles;

  ParticleList() {
    particles = new ArrayList<Particle>();
  }

  void update() {
  }
  void setup() {
  }
  void display() {
  }
  void collide() {
  }
  void addParticle(Particle particle, PVector pos, int type) { //TYPES: 0 = player, 1 = player bullet, 2 = Enemy Bullet, 3 = Enemy, 4 = explosion bit
    particles.add(particle);
    particle.position = pos;
    particle.type = type;
  }
}
