class_Enemy[][] enemies;
Projectile[] projectiles;
int bsize = 15;
PVector center;
PVector shipCenter;
class_Enemy spaceship;
int pCount = 0;


void setup() {
  size(500, 500);

  shipCenter = new PVector (width/2, (9 * height/10)); // creates user-operated spaceship
  spaceship = new class_Enemy(shipCenter, bsize);

  enemies = new class_Enemy[5][5];
  projectiles = new Projectile[1000];
  frameRate(30);
  makeEnemies(enemies);
  makeGrid(enemies);
}

void draw() {
  background(240);
  spaceship.display();

  for (int i = 0; i < projectiles.length; i++) {
    if (projectiles[i] != null) {
      projectiles[i].move();
      projectiles[i].display();
    }
  }

  for (int i = 0; i < enemies.length; i++) { //display enemies (maybe this should go in setup? idk)
    for (int j = 0; j < enemies[i].length; j++) {
      enemies[i][j].display();
      if (frameCount % 10 == 0) { //move enemies
        enemies[i][j].move();
      }
    }
  }
}

void makeEnemies(class_Enemy[][] e) {
  int x = width/20;
  int y = height/20;
  for (int i = 0; i < e.length; i++) {
    for (int j = 0; j < e[i].length; j++) {
      center = new PVector(x, y);
      e[i][j] = new class_Enemy(center, bsize);
      x += bsize + 20;
    }
    x = width/20;
    y += bsize + 20;
  }
}

void makeGrid(class_Enemy[][] e) {
  for (int i = 0; i < e.length; i++) {
    for (int j = 0; j < e[i].length; j++) {
      if (e[i][j] != null) {
        circle(e[i][j].center.x, e[i][j].center.y, e[i][j].bsize);
      }
    }
  }
}
void makeProjectile() {
  projectiles[pCount] = new Projectile (shipCenter, bsize/2);
  pCount += 1;
}

void keyPressed() {
  if (key == ' ') {
    makeProjectile();
    println("made projectile");
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      spaceship.center.x -= 10;
      shipCenter.x = spaceship.center.x;
    }
    if (keyCode == RIGHT) {
      spaceship.center.x += 10;
      shipCenter.x = spaceship.center.x;
    }
  }
}
