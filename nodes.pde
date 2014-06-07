int ids = 1;
int lifeLimit = 500;
int birthLimit = 300;
boolean drag = false;

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

class antiNode extends node {
  antiNode (float parentX, float parentY, float parentSize) {
    super(parentX, parentY, parentSize);
  }
}
ArrayList nodes;
int StartingNodes = 30;
String[] titles = {"A GAME OF NODES", "IT'S A HARD NODE LIFE", "A NODE'S LIFE"};
String[] creators = {"A wizard", "A pirate", "Jon Snuhh", "Bill O'Reilly", "My Dog", "A Programmer DUH!", "Sweatshop Workers", "FOXCONN", "/u/Olshrimpeyes"};
String title;
String creator;

void setup () {
  size(675, 555);
  nodes = new ArrayList();
  title = titles[int(random(0, titles.length))];
  creator = creators[int(random(0, creators.length))];
  for (int i = 0; i < StartingNodes; i++) {
    nodes.add(new node());
    smooth();
    textAlign(CENTER);
  }
}

boolean splash = true;

void draw () {
  if (millis() < 5000) {
    splashScreen();
  } else {
    background(255);
    textSize(10);
    rectMode(CORNER);
    fill(150);
    strokeWeight(1.25);
    rect(555, -10, 125, 575);
    int size = nodes.size();
    int list = 15;
    for (int i = 0; i < size; i++) {
      node Node = (node) nodes.get(i);
      if (mouseX > 555 && mouseY > list - 5 && mouseY < list + 5 || mouseX > Node.x - Node.size/2 && mouseX < Node.x + Node.size/2 && mouseY > Node.y - Node.size/2 && mouseY < Node.y + Node.size/2) {
        Node.highlight = true;
      } else {
        Node.highlight = false;
      }
      Node.act();
      Node.render();
      if (Node.highlight) {
        if (list > 515) {
        } else if (list == 515) {
          fill(0);
          text("...", 615, 515);
          } else if (Node.life > lifeLimit/2) {
          fill(0);
          text(str(i + 1) + ": " + Node.id+ "; " + str(Node.life), 615, list);
        } else if (Node.life > 0) {
          fill(0);
          text(str(i + 1) + ": " + Node.id + "; " + str(Node.life), 615, list);
        } else if (Node.newLife > 0) {
          fill(0);
          text(str(i + 1) + ": " + Node.id + "; " + str(Node.newLife), 615, list);
        } else {
          fill(0);
          text(str(i + 1) + ": " + Node.id, 615, list);
        }
      } else {
        if (list > 515) {
        } else if (list == 515) {
          fill(0);
          text("...", 615, 515);
          } else if (Node.life > lifeLimit/2) {
          fill(#FF4D4D);
          text(str(i + 1) + ": " + Node.id+ "; " + str(Node.life), 615, list);
        } else if (Node.life > 0) {
          fill(#FFF86C);
          text(str(i + 1) + ": " + Node.id + "; " + str(Node.life), 615, list);
        } else if (Node.newLife > 0) {
          fill(#9DFF58);
          text(str(i + 1) + ": " + Node.id + "; " + str(Node.newLife), 615, list);
        } else {
          fill(#9DFF58);
          text(str(i + 1) + ": " + Node.id, 615, list);
        }
      }
      list += 10;
      if (Node.birth) {
        if (int(random(0,100)) > 75) {
          nodes.add(new node(Node.x, Node.y, Node.size));
        } else {
          nodes.add(new antiNode(Node.x, Node.y, Node.size))
        }
        Node.birth = false;
      }
    }
    fill(0);
    text("Last assigned ID", 615, 535);
    text(hex(ids - 1), 615, 545);
    connections(size);
    kill(size);
    fill(0);
    text(size, 20, 20);
    //saveFrame("./Frames/frame-########.JPG");
  }
}

void connections (int size) {
  int connections = 0;
  int halfConnections = 0;
  for (int i = 0; i < size; i++) {
    node Node = (node) nodes.get(i);
    Boolean Alone = true;
    for (int c = 0; c < size; c++) {
      stroke(0);
      strokeWeight(.5);
      node NodeII = (node) nodes.get(c);
      float xone = Node.x;
      float xtwo = NodeII.x;
      float yone = Node.y;
      float ytwo = NodeII.y;
      if (NodeII == Node) {
        print("");
      } else if (abs(xone - xtwo) > (Node.radius + NodeII.radius)/2 || abs(yone - ytwo) > (Node.radius + NodeII.radius)/2 ) {
        print("");
      } else if (abs(xone - xtwo) > (Node.halfRadius + NodeII.halfRadius)/2 || abs(yone - ytwo) > (Node.halfRadius + NodeII.halfRadius)/2 ) {
        stroke(150);
        line(xone, yone, xtwo, ytwo);
        Alone = false;
        Node.notAlone();
        halfConnections++;
        connections++;
      } else {
        stroke(0);
        line(xone, yone, xtwo, ytwo);
        Alone = false;
        Node.notAlone();
        connections++;
      }
      if (c == size - 1 && Alone) {
        Node.isAlone();
        connections = 0;
      } else if (c == size - 1) {
        Node.connections(connections, halfConnections);
        connections = 0;
      }
    }
  }
}

void kill (int size) {
  for (int i = size - 1; i >= 0; i--) {
    node Node = (node) nodes.get(i);
    if (Node.dead) {
      nodes.remove(i);
    }
  }
}



void mouseReleased() {
  if (drag) {
    for (int i = 0; i < nodes.size(); i++) {
      node Node = (node) nodes.get(i);
      if (Node.dragging) {
        Node.dragging = false;
        drag = false;
      }
    }
  } else if (mouseX < 555){
    nodes.add(new node(mouseX, mouseY));
  } else {
    for (int i = 0; i < nodes.size(); i++) {
      node Node = (node) nodes.get(i);
      if (Node.highlight && !Node.rollover) {
        Node.dead = true;
      }
    }
  }
}

void splashScreen() {
  background(255);
  textAlign(CENTER);
  textSize(45);
  fill(0);
  text(title, width/2, height/2);
  textSize(20);
  fill(145);
  text("Created by: " + creator, width/2 , height/2 + 25);
}

