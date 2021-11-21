ArrayList<Node> nodes;
ArrayList<Edge> edges;

float rejDist = 50;
float sqRejDist;

float maxEdge = 30;
float sqMaxEdge;

float minEdge = 8;
float sqMinEdge;

float idealDist = 20;

int growthCount = 0;

boolean run = true;


void setup(){
  // Page setup
  size(800,800,P2D);
  // Filling starting circle with nodes and edges
  // Rand angle is added to introduce irregularities
  nodes = new ArrayList<Node>();
  edges = new ArrayList<Edge>();
  for (int i = 0; i < 12; i++){
    float rand = random(.3);
    int sign = round(random(1))*2-1;
    nodes.add(new Node(new PVector(50*cos(TWO_PI/12*i+sign*rand) + width/2,50*sin(TWO_PI/12*i+sign*rand) + height/2)));
    if (i>0){
      edges.add(new Edge(nodes.get(i-1), nodes.get(i)));
    }
  }
  edges.add(new Edge(nodes.get(nodes.size()-1), nodes.get(0)));

  // Calculating squares of distances
  sqRejDist = sq(rejDist);
  sqMaxEdge = sq(maxEdge);
  sqMinEdge = sq(minEdge);
}

void draw(){
  // Drawing BG
  background(250, 250, 250);
  // First iteration trough Nodes
  // This iteration is used for:
  //   - nulling previous attractions and rejections
  //   - calculating new rejections
  for (Node node : nodes){ //<>// //<>//
    node.nullAttr();
    node.nullRej(); //<>//
    for (Node n : nodes) {
      if (!node.equals(n)){ //<>//
        float sqDist = abs(sq((n.pos.x - node.pos.x)) + sq((n.pos.y - node.pos.y)));
        if (sqDist <= sqRejDist) {
          PVector rej = PVector.sub(n.pos, node.pos);
          rej.setMag(rej.mag()-rejDist); //<>// //<>//
          node.addRej(rej.mult(2));
        } //<>//
      }
    } //<>//
  }

  // First iteration trough Edges
  // This iteration is used for:
  //   - adding new nodes where nessesary or at random
  //   - displaying edges (TODO: probably shoul do elsewhere)
  //   - calculating attractions
  for (int i = 0; i < edges.size(); i++){
    Edge edge = edges.get(i);
    float sqDist = abs(sq((edge.node1.pos.x - edge.node2.pos.x)) + sq((edge.node1.pos.y - edge.node2.pos.y)));
    boolean split = split(edge, sqDist);
    if (!split){
      PVector prevDir, dir;
      if (i > 0){
        prevDir = edges.get(i-1).getDir().mult(-1).normalize();
      } else {
        prevDir = edges.get(0).getDir().mult(-1).normalize();
      }
      dir = edge.getDir().normalize();
      float curv = (PVector.dot(prevDir, dir)+1.0)/2.0;
      edge.node1.setCurve(curv);
      if (random(1) < curv && random(1) > .99){
        growth(edge, sqDist);
        split = true;
        // growthCount++;
        // println("GROWTH", growthCount);
      }
    }/*
    if (!split){
      PVector nextDir, dir;
      if (i < edges.size()-1){
        nextDir = edges.get(i+1).getDir().mult(-1).normalize();
      } else {
        nextDir = edges.get(0).getDir().mult(-1).normalize();
      }
      dir = edge.getDir().normalize();
      float curv = (PVector.dot(nextDir, dir)+1.0)/2.0;
      edge.node2.setCurve(curv);
      if (random(1) < curv && random(1) > .99){
        growth(edge, sqDist);
        split = true;
        // growthCount++;
        // println("GROWTH", growthCount);
      }
    }*/
    edge.addAttr(idealDist);
    edge.display();
    // edge.display(edges.indexOf(edge));
    // println(edges.indexOf(edge));
  }

  // Second iteration trough Nodes
  // Making movement and displaying nodes
  for (Node node : nodes){
    node.step(); //<>//
    node.displayAttr();
    // node.displayRej();
    node.display();
    if (node.pos.x < 0 || node.pos.x > width || node.pos.y < 0 || node.pos.y > height){
      run = false;
    }
  }

  if (!run){
    noLoop();
  }
} //<>//

// The spliting algorithm based on edge distances
boolean split(Edge edge, float sqDist){
  if (sqDist >= sqMaxEdge){
    PVector newPos = PVector.add(edge.node1.pos, PVector.sub(edge.node2.pos, edge.node1.pos).div(2)); //<>//
    Node nn = new Node(newPos);
    int index = edges.indexOf(edge);
    edges.add(index + 1, new Edge(nn, edge.node2));
    edge.split(nn);
    nodes.add(nn);
    return true;
  }
  return false;
}

// The growth algorithm based (only if mindist)
void growth(Edge edge, float sqDist){
  if (sqDist >= sqMinEdge){
    PVector newPos = PVector.add(edge.node1.pos, PVector.sub(edge.node2.pos, edge.node1.pos).div(2)); //<>//
    Node nn = new Node(newPos);
    int index = edges.indexOf(edge);
    edges.add(index + 1, new Edge(nn, edge.node2));
    edge.split(nn);
    nodes.add(nn);
  }
}
