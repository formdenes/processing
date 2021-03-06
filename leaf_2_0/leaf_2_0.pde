Sources sources;
Vein vein;
PVector[] vertices = new PVector[8];

int dartThrows = 300;
int ro = 300;

float growth = 0.2;
float startWidth = 10;
float minWidth = 1.5;

int step = 20;
int BIRTHDIST = 1;
int KILLDIST = 2;
float minAngle = 0.02;

float nodeSize = 1.0;
float sourceSize = 3.0;

int exponent = 4;
float z = 5;
float f = 0.05;
float s = 10;
PVector o = new PVector(5,9);

void setup() {
	size(1000, 1000, P2D);
  smooth(4);
  dartThrows = max(floor(ro / pow(10,6) * s * s * z * z), 1);
  vein = new Vein(new Node(width / 2, height - nodeSize));
  vein.nodes.get(0).weight = 10;
  // vein.addNode(new Node(width / 2, height - 2 * nodeSize));
  // vein.addNode(new Node(width / 2, height - 3 * nodeSize));
  background(230);
  vein.show(color(20), nodeSize); //<>//
  sources = new Sources(dartThrows);
  sources.show(color(255,0,0), sourceSize); //<>//
  vertices[0] = new PVector(5,0);
  vertices[1] = new PVector(9,4);
  vertices[2] = new PVector(9,7);
  vertices[3] = new PVector(8,8);
  
  vertices[4] = new PVector(5,9);
  vertices[5] = new PVector(2,8);
  vertices[6] = new PVector(1,7);
  vertices[7] = new PVector(1,4);
  // for(int i=0; i<vertices.length;i++){
  //   vertices[i].x = vertices[i].x * width / 10;
  //   vertices[i].y = vertices[i].y * height / 10;  //<>//
  // }
	//frameRate(30); //<>//
}

void draw() {
  background(230);
  sources.generate(vein, vertices); //<>//
  // sources.generate(vein);
  sources.findNearestNodes(vein); //<>//
  // vein.showSources(color(230, 0, 0)); 
  vein.norm();
  vein.calcMasses(); //<>//
  // vein.show(color(20), nodeSize); 
  vein.addNodes(); //<>//
  // vein.show(color(20), nodeSize, false); 
  // vein.show(color(216, 237, 211), nodeSize, false); 
  vein.show(color(60, 79, 55), nodeSize, false); 
  sources.removeSources(vein);
  sources.show(color(255,0,0), sourceSize);
  // vein.showNorms(color(0,0,250));  //<>//
  //vein.showMasses(color(0,250,0));
  z =  constrain(z + f,1, min(width / 10, height / 10));
  dartThrows = max(floor(ro / pow(10,6) * s * s * z * z), 1);
  println(vein.size(), sources.size(), frameRate, dartThrows); //<>// //<>//
}
