int ids = 1;
int lifeLimit = 500;
int birthLimit = 300;
boolean drag = false;

ArrayList nodes;
int StartingNodes = 30;

void setup () {
  size(675, 555);
  nodes = new ArrayList();
  for (int i = 0; i < StartingNodes; i++) {
    nodes.add(new node());
    smooth();
    textAlign(CENTER);
  }
}

boolean splash = true;

void draw() {
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
      nodes.add(new node(Node.x, Node.y, Node.size));
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
    for (int i = 0; i < nodes.size (); i++) {
      node Node = (node) nodes.get(i);
      if (Node.dragging) {
        Node.dragging = false;
        drag = false;
      }
    }
  } else if (mouseX < 555) {
    nodes.add(new node(mouseX, mouseY));
  } else {
    for (int i = 0; i < nodes.size (); i++) {
      node Node = (node) nodes.get(i);
      if (Node.highlight && !Node.rollover) {
        Node.dead = true;
      }
    }
  }
}

