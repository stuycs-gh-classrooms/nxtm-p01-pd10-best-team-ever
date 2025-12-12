class class_Enemy {

  //VARIABLES
  PVector center;
  int xspeed = 1;
  int yspeed = 0;
  int bsize;
  color c;
  boolean exist;
  int numLives;
  
  //CONSTRUCTOR
  class_Enemy(PVector p, int s, int l) {
    bsize = s;
    center = new PVector(p.x, p.y);
    numLives = l;
  }

  //METHODS
  boolean collideYesNo(class_Enemy other) { // Did class_Enemys collide?
    return (this.center.dist(other.center) <= (this.bsize/2 + other.bsize/2)); // returns true or false
  }



  void display() {
    fill(255);
    circle(center.x, center.y, bsize);
  }

  void move() {
    if (center.x > width - bsize/2 || center.x < bsize/2) {
      xspeed *= -1;
      yspeed += bsize/2 + 10;
      center.y += yspeed;
    }
    if (center.y > height - bsize/2 || center.y < bsize/2) {
      center.y -= yspeed;
    }
    else {
      center.x += xspeed;
    }

  }
}
