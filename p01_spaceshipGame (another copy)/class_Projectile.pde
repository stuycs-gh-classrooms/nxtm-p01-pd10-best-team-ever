
class Projectile {
  //VARIABLES
  PVector center;
  int yspeed;
  int bsize;
  color c;

  //CONSTRUCTOR
  Projectile(PVector p, int s) {
    bsize = s;
    center = new PVector(p.x, p.y);
  }

  //METHODS
  boolean shipCollision(class_Enemy x) {
    return (this.center.dist(x.center) <= (this.bsize/2 + x.bsize/2));
  }

  void display() {
    fill(0);
    circle(center.x, center.y, bsize);
  }

  void moveUp() {
    center.y -= 3;
  }

  void moveDown() {
    center.y += 3;
  }
}
