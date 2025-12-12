class_Enemy[][] enemies;
class_Enemy spaceship;
Projectile[] projectiles; //stores projectiles so a new one can be made each time
int bsize = 15;
PVector center;
PVector shipCenter; // center of user-operated spaceship
int pCount = 0; // number of projectiles fired


void setup() {
  size(500, 500);

  shipCenter = new PVector (width/2, (9 * height/10)); // creates user-operated spaceship
  spaceship = new class_Enemy(shipCenter, bsize);
  projectiles = new Projectile[1000]; // 1D array, stores spaceship missiles availiable

  enemies = new class_Enemy[5][25];
  frameRate(30);
  makeEnemies(enemies);
  makeGrid(enemies);
}

void draw() {
  background(240);
  if (pCount > 0) {
    for (int x = 0; x < enemies.length; x++) {
      for (int j = 0; j < enemies[x].length; j++) {
        for (int i = 0; i < pCount; i++) {
          float d = dist(projectiles[i].center.x, projectiles[i].center.y, enemies[x][j].center.x, enemies[x][j].center.y);
          //          println(d);
          if (d <= bsize) {
            println("COLLIDE");
          }
        }
      }
    }
  }
  processCollisions();
  spaceship.display();

  for (int i = 0; i < projectiles.length; i++) {
    if (projectiles[i] != null) {
      projectiles[i].moveUp();
      projectiles[i].display();
    }
  }

  for (int i = 0; i < enemies.length; i++) { //display enemies (maybe this should go in setup? idk)
    for (int j = 0; j < enemies[i].length; j++) {
      enemies[i][j].display();
      if (frameCount % 10 == 0) { //move enemies
        //      println("move enemies");
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

void processCollisions() {
  for (int u = 0; u < enemies.length; u++) {
    for (int j = 0; j < enemies[u].length; j++) {
      if (enemies[u][j].exist == false) {
//        enemies[u][j] = null;
      }
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    makeProjectile();
    //    println("made projectile");
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
