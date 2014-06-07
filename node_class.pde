class node {
  String data;
  int connections;
  float x;
  float y;
  float size;
  float Xspeed;
  float Yspeed;
  float radius;
  float halfRadius;
  String id;
  boolean Alone = false;
  int newLife = 0;
  int life = 0;
  int trans = 170;
  boolean highlight = false;
  boolean dead = false;
  boolean birth = false;
  boolean dragging = false;
  boolean rollover = false;
  node () {
    id = hex(ids);
    print(id + " Created! \n");
    ids++;
    ellipseMode(CENTER);
    size = random(5, 75);
    x = random(0 + size/2, 555 - size/2);
    y = random(0 + size/2, 555 - size/2);
    Xspeed = random(-.5, .5);
    Yspeed = random(-.5, .5);
  }
  node (float tempX, float tempY) {
    id = hex(ids);
    print(id + " Created! \n");
    ids++;
    ellipseMode(CENTER);
    x = tempX;
    y = tempY;
    size = random(5, 75);
    Xspeed = random(-.5, .5);
    Yspeed = random(-.5, .5);
    if (x > 555 - size/2 || x < 0 + size/2 || y > 555 - size/2 || y < 0 + size/2 ) {
      x = random(0 + size/2, 555 + size/2);
      y = random(0 + size/2, 555 + size/2);
    }
  }
  node (float parentX, float parentY, float parentSize) {
    id = hex(ids);
    print(id + " Created \n");
    ids++;
    ellipseMode(CENTER);
    x = parentX + random(-parentSize, parentSize);
    y = parentY + random(-parentSize, parentSize);
    size = parentSize + random(-parentSize/2, parentSize/2);
    Xspeed = random(-.5, .5);
    Yspeed = random(-.5, .5);
    if (x > 555 - size/2 || x < 0 + size/2 || y > 555 - size/2 || y < 0 + size/2 ) {
      x = random(0 + size/2, 555 + size/2);
      y = random(0 + size/2, 555 + size/2);
    }
  }
  void act () {
    data = id + ": Connections: " + connections + ", Life Points: " + str(life) + ", Birth: " + str(newLife)+ ", X: " + str(x) + ", Y: " + str(y) + ", Size: " + str(size) + "\n";
    radius = sqrt(size)*12;
    halfRadius = sqrt(size)*6;
    if (mouseX > x - size/2 && mouseX < x + size/2 && mouseY > y - size/2 && mouseY < y + size/2) {
      rollover = true;
    } else {
      rollover = false;
    }
    if (newLife == birthLimit) {
      birth = true;
      newLife = 0;
    }
    if (life == lifeLimit) {
      dead = true;
      x = 100000;
      y = 100000;
      print(id + " died \n");
    } else {
      if (x <= size * .5) {
        Xspeed = abs(Xspeed);
      }
      if (y <= size * .5) {
        Yspeed = abs(Yspeed);
      }
      if (x >= 555 - size * .5) {
        Xspeed = -Xspeed;
      }
      if (y >= 555 - size * .5) {
        Yspeed = -Yspeed;
      }
    }
    if (mousePressed && mouseX > x - size/2 && mouseX < x + size/2 && mouseY > y - size/2 && mouseY < y + size/2 && !drag || dragging) {
      dragging = true;
      drag = true;
      x = mouseX;
      y = mouseY;
    } else {
      x += Xspeed;
      y += Yspeed;
    }
  }
  void render () {
    if (dragging) {
      trans = 85;
    } else {
      trans = 170;
    }
    if (highlight) {
      stroke(#000000, trans);
    } else {
      noStroke();
    }
    if (life > lifeLimit/2) {
      fill(#FF4D4D, trans);
    } else if (life > 0) {
      fill(#FFF86C, trans);
    } else {
      fill(#9DFF58, trans);
    }
    if (dragging) {
      ellipse(x, y, size + 5, size + 5);
    } else {
      ellipse(x, y, size, size);
    }
  }
  void isAlone() {
    if (nodes.size() <= 2) {
      Alone = false;
    } else {
      Alone = true;
      life++;
      newLife = 0;
    }
  }
  void notAlone() {
    Alone = false;
  }
  void connections(int conn, int halfConn) {
    connections = conn;
    if (conn == 1) {
      newLife++;
      life = 0;
    } else if (conn > 3) {
      newLife = 0;
      life ++;
    } else {
      life = 0;
      newLife = 0;
    }
  }
  void outOfBounds () {
    if (x > 555 - size/2 || x < 0 + size/2 || y > 555 - size/2 || y < 0 + size/2 ) {
      x = random(0 + size/2, 555 + size/2);
      y = random(0 + size/2, 555 + size/2);
    }
  }
}
