class Spaceship {

  //VARIABLES
  PVector center;
  int xspeed;
  int yspeed;
  int bsize;
  color c;

  //CONSTRUCTOR
  Spaceship(PVector p, int s) {
    bsize = s;
    center = new PVector(p.x, p.y);
  }

  //METHODS
  boolean collideYesNo(Spaceship other) { // Did spaceships collide?
    return (this.center.dist(other.center) <= (this.bsize/2 + other.bsize/2)); // returns true or false
  }

  void setColor(color x) {
    c = newC;
  }

  void display() {
    fill(c);
    
    
    
    
    
