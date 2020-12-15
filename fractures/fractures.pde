Sources sources;
ArrayList<Fracture> fractures;

float FOV = 50;
float minFov = 10;
float STEP = 8;
float CHANCE = .8;
int maxSources = 100;
int BIRTHDIST = 1;

color sCol = color(240, 0, 0);
float sSize = 2;
color fcol = color(40, 40, 40);
float fsize = 3;

boolean span = true;

void setup(){
  size(500, 500, P2D);
  background(240);
  sources = new Sources();
  fractures = new ArrayList<Fracture>();
  Node firstNode1 = new Node(width/2, height/3);
  Node firstNode2 = new Node(width/3, height/2);
  Node firstNode3 = new Node(width/3*2, height/2);
  fractures.add(new Fracture(firstNode1));
  fractures.add(new Fracture(firstNode2));
  fractures.add(new Fracture(firstNode3));
  Fracture fracture = fractures.get(0);
  fracture.show(fcol, fsize, true);
  fracture.showNorms();
  fracture.showMasses();
  sources.generate(maxSources);
  sources.generate(maxSources);
  sources.generate(maxSources);
}

void draw(){
  ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
  background(240);
  sources.generate(maxSources);
  sources.findNearestNodes(fractures);
  sources.show(sCol, sSize);
  int size = fractures.size();
  for(int i = 0; i < size; i++){
    Fracture fracture = fractures.get(i);
    fracture.norm();
    sourcesToRemove.addAll(fracture.calcMasses());
    fracture.addNode(fractures);
    boolean terminated = fracture.terminated;
    if(!terminated && random(1) < CHANCE && span){
        PVector prevPos = fracture.nodes.get(fracture.nodes.size() - 1).pos;
        PVector step = PVector.random2D().mult(STEP);
        PVector newPos = PVector.add(prevPos, step);
        Fracture _fracture = new Fracture(new Node(prevPos.x, prevPos.y)); //<>//
        _fracture.addNode(new Node(newPos.x, newPos.y), fractures);
        fractures.add(_fracture);
    }
    fracture.show(fcol, fsize, false);
    // fracture.showNorms();
    // fracture.showMasses();
  }
  sources.removeSources(sourcesToRemove);
  println(frameRate, nodeCount(), activeFractureCount()); //<>//
}

int nodeCount() {
  int count = 0;
  for(Fracture frac : fractures){
    count += frac.nodes.size();
  }
  return count;
}

int activeFractureCount(){
  int count = 0;
  for(Fracture frac : fractures){
    if(!frac.terminated){count++;}
  }
  return count;
}
