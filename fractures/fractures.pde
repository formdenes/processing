Sources sources;
ArrayList<Fracture> fractures;

float FOV = 50;
float STEP = 10;
float CHANCE = .1;
int maxSources = 1000;

color sCol = color(240, 0, 0);
float sSize = 2;
color fcol = color(40, 40, 40);
float fsize = 3;

void setup(){
  size(500, 500);
  background(240);
  sources = new Sources();
  fractures = new ArrayList<Fracture>();
  Node firstNode = new Node(width/2, height/2);
  fractures.add(new Fracture(firstNode));
  Fracture fracture = fractures.get(0);
  fracture.show(fcol, fsize, true);
  fracture.showNorms();
  fracture.showMasses();
  sources.generate(maxSources);
}

void draw(){
  ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
  background(240);
  sources.findNearestNodes(fractures);
  sources.show(sCol, sSize);
  int size = fractures.size();
  for(int i = 0; i < size; i++){
    Fracture fracture = fractures.get(i);
    fracture.norm();
    sourcesToRemove.addAll(fracture.calcMasses());
    fracture.addNode();
    boolean terminated = fracture.terminate();
    if(!terminated){
      if(random(1) < CHANCE){
        PVector prevPos = fracture.nodes.get(fracture.nodes.size() - 1).pos;
        PVector step = PVector.random2D().mult(STEP);
        PVector newPos = PVector.add(prevPos, step);
        Fracture _fracture = new Fracture(new Node(prevPos.x, prevPos.y)); //<>//
        _fracture.addNode(new Node(newPos.x, newPos.y));
        fractures.add(_fracture);
      }
    }
    fracture.show(fcol, fsize, false);
    // fracture.showNorms();
    // fracture.showMasses();
  }
  println(frameRate, nodeCount()); //<>//
}

int nodeCount() {
  int count = 0;
  for(Fracture frac : fractures){
    count += frac.nodes.size();
  }
  return count;
}
