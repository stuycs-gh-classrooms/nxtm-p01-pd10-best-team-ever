class_Enemy[][] enemies;
class_Enemy spaceship;
Projectile[] projectiles; //stores projectiles so a new one can be made each time
Projectile[] enemyProjectiles; //stores projectiles of enemies
int bsize = 15;
PVector center;
PVector pCenter; //projectile center
PVector shipCenter; // center of user-operated spaceship
int pCount = 0; // number of projectiles fired
int pEnemyCount = 0; //numer of enemy projectiles fired
int currentShooters = 0;
int xspeed = 1;
int yspeed = 1;
boolean playing;
boolean win;
int enemyDifficulty = 5;

void setup() {
  size(500, 500);
  textAlign(CENTER, CENTER);

  shipCenter = new PVector (width/2, (9 * height/10)); // creates user-operated spaceship
  spaceship = new class_Enemy(shipCenter, bsize);
  projectiles = new Projectile[1000];
  enemyProjectiles = new Projectile[10000];
  spaceship.exist = true;

  enemies = new class_Enemy[5][25];
  frameRate(30);
  makeEnemies(enemies);
  makeGrid(enemies);
}

void draw() {
  background(240);
  if (playing != true) {
    textSize(20);
    fill(0);
    text("CLICK ENTER TO START GAME", width/2, height/2);
  }

  processCollisions(projectiles, enemies);
  processShipCollisions(enemyProjectiles, spaceship);

  if (spaceship.exist != false) {
    spaceship.display();
  }
  //MAKE ENEMY PROJECTILES MOVE
  if (playing == true) {
    for (int i = 0; i < enemyProjectiles.length; i++) {
      if (enemyProjectiles[i] != null) {
        //      println("shoot projectile");
        enemyProjectiles[i].moveDown();
        enemyProjectiles[i].display();
      }
    }
    //MAKE SPACSHIP PROJECTILES MOVE
    for (int i = 0; i < projectiles.length; i++) { //displays,moves projectiles
      if (projectiles[i] != null) {
        projectiles[i].moveUp();
        projectiles[i].display();
      }
    }
    //DISPLAY,MOVE ENEMIES
    for (int i = 0; i < enemies.length; i++) { //display enemies (maybe this should go in setup? idk)
      for (int j = 0; j < enemies[i].length; j++) {
        if (enemies[i][j] != null) {
          enemies[i][j].move();
          enemies[i][j].display();

          //ENEMY PROJECTILES
          if (frameCount % 80 == 0) { // only 10 random enemies shoot at a time
            if (random(1) < 0.01 * enemyDifficulty) {
              pCenter = (enemies[i][j].center.copy());
              makeEnemyProjectile(enemyProjectiles);
            }
          }
        }
      }
    }
  }
}

void reset() {
  enemyDifficulty += 5;
  playing = true;

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
        e[i][j] = new class_Enemy(e[i][j].center, e[i][j].bsize);
      }
    }
  }
}

void makeProjectile(Projectile[] p) { // makes spaceship projectiles
  p[pCount] = new Projectile (shipCenter, bsize/2);
  pCount += 1;
}
void makeEnemyProjectile(Projectile[] p) { //makes enemy projectiles
  p[pEnemyCount] = new Projectile (pCenter, bsize/2);
  pEnemyCount += 1;
}

void processCollisions(Projectile[] p, class_Enemy[][] e) { //process collisions
  for (int i = 0; i < e.length; i++) { //loop through enemies
    for (int u = 0; u < e[i].length; u++) { //loop through enemies
      for (int o = 0; o < pCount; o++) { //loop through projectiles
        if (e[i][u] != null) {
          if (p[o] != null) {
            float d = dist(p[o].center.x, p[o].center.y, e[i][u].center.x, e[i][u].center.y);
            //                  println(d); //return distance between projectile and enemy
            if (d < bsize) { //if distance too small,
              //              println("COLLIDE"); //objects "collide"
              e[i][u] = null; // enemy disappears
              p[o] = null; //projectile disappears
            }
          }
        }
      }
    }
  }
}

void keyPressed() { //control spaceship
  if (key == ENTER) {
    //    textSize(30);
    //    fill(0);
    //    int i = 0;
    //    while (i < 5) {
    //      if (frameCount % 10 == 0) {
    //       if (i == 0) {
    //        text("3", width/2, height/2);
    //                 i++;
    //        }
    //        if (i == 1) {
    //          text("2", width/2, height/2);
    //                    i++;
    //        }
    //        if (i == 2) {
    //          text("1", width/2, height/2);
    //                    i++;
    //        }
    //        if (i == 3) {
    //          text("START", width/2, height/2);
    //                    i++;
    //        }
    //        if (i == 4) {
    playing = true;
    //        }
    //      }
    //    }
  }
  if (key == TAB) {
    playing = false;
  }

  if (spaceship == null) {
    playing = false;
    reset();
  }
  if (playing == true) {
    if (key == ' ') {
      makeProjectile(projectiles);
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
}

void processShipCollisions(Projectile[] p, class_Enemy e) { //process collisions
  for (int o = 0; o < pEnemyCount; o++) { //loop through projectiles
    if (p[o] != null) { // if projectile exists
      if (e != null) {
        float d = dist(p[o].center.x, p[o].center.y, e.center.x, e.center.y);
        //println(d); //return distance between projectile and enemy
        if (d < bsize) { //if distance too small,
          //        println("COLLIDE"); //objects "collide"
          e.exist = false;
          e = null; // enemy disappears
          p[o] = null; //projectile disappears
          win = false;
        }
      }
    }
  }
}
