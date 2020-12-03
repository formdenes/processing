Sources sources;
Vein vein;

int dartThrows = 300;
int ro = 300;

float growth = 0.2;
float startWidth = 10;
float minWidth = 1.5;

int step = 20;
int BIRTHDIST = 5;
int KILLDIST = 10;
float minAngle = 0.02;

float nodeSize = 10.0;
float sourceSize = 3.0;

int exponent = 5;


void setup() {
	size(1000, 1000, P2D);
  dartThrows = floor(ro / pow(10,6) * width * height);
  vein = new Vein(new Node(width / 2, height - nodeSize));
  vein.nodes.get(0).weight = 10;
  // vein.addNode(new Node(width / 2, height - 2 * nodeSize));
  // vein.addNode(new Node(width / 2, height - 3 * nodeSize));
  background(230);
  vein.show(color(20), nodeSize);
  sources = new Sources(dartThrows);
  sources.show(color(255,0,0), sourceSize); //<>//
	frameRate(30); //<>//
}

void draw() {
  background(230);
  sources.generate(vein);
  sources.findNearestNodes(vein); //<>//
  // vein.showSources(color(230, 0, 0)); 
  vein.norm();
  vein.calcMasses();
  // vein.show(color(20), nodeSize); 
  vein.addNodes(); //<>//
  vein.show(color(20), nodeSize, false); 
  sources.removeSources(vein);
  sources.show(color(255,0,0), sourceSize);
  // vein.showNorms(color(0,0,250)); 
  vein.showMasses(color(0,250,0)); 
  println(vein.size(), sources.size()); //<>// //<>//
}
