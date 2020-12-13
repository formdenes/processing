Sources sources;
Fractures fractures;

float FOV = 50;
float STEP = 10;
int maxSources = 1000;

color sCol = color(240, 0, 0);
float sSize = 2;
color fcol = color(40, 40, 40);
float fsize = 3;

void setup(){
  size(500, 500);
  background(240);
  Node firstNode = new Node(width/2, height/2);
  fractures = new Fractures(firstNode);
  sources = new Sources();
  fractures.show(fcol, fsize, true);
  fractures.showNorms();
  fractures.showMasses();
}

void draw(){
  background(240);
  // sources.generate(maxSources);
  sources.findNearestNodes(fractures);
  fractures.norm();
  fractures.calcMasses();
  fractures.addNodes();
  sources.show(sCol, sSize);
  fractures.show(fcol, fsize, false);
  // fractures.showNorms();
  // fractures.showMasses();
}
